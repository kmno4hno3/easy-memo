class Api::V1::OmniauthCallbacksController < DeviseTokenAuth::OmniauthCallbacksController
  skip_before_action :skip_session

  def redirect_callbacks
    p "リダイレクト"
    # derive target redirect route from 'resource_class' param, which was set
    # before authentication.
    devise_mapping = get_devise_mapping
    redirect_route = get_redirect_route(devise_mapping)

    # preserve omniauth info for success route. ignore 'extra' in twitter
    # auth response to avoid CookieOverflow.
    session['dta.omniauth.auth'] = request.env['omniauth.auth'].except('extra')
    session['dta.omniauth.params'] = request.env['omniauth.params']

    redirect_to redirect_route
  end

  def omniauth_success
    p "成功"
    get_resource_from_auth_hash
    set_token_on_resource
    create_auth_params

    # if confirmable_enabled?
    #   # don't send confirmation email!!!
    #   @resource.skip_confirmation!
    # end

    sign_in(:user, @resource, store: false, bypass: false)

    @resource.save!

    # # 動作確認用にユーザ情報を保存できたらjsonをそのまま返す処理
    # if @resource.save!
    #   # update_token_authをつけることでレスポンスヘッダーに認証情報を付与できる。
    #   update_auth_header
    #   yield @resource if block_given?
    #   render json: @resource, status: :ok
    #   # redirect_to "https://a2edbf5198ec.ngrok.io/"
    # else
    #   render json: { message: "failed to login" }, status: 500
    # end

    yield @resource if block_given?
    render_data_or_redirect('deliverCredentials', @auth_params.as_json, @resource.as_json)
  end

  def omniauth_failure
    p "失敗"
    super
  end

  protected

  # 認証パラメーター(@_omniauth_params)生成
  def omniauth_params
    unless defined?(@_omniauth_params)
      if request.env['omniauth.params'] && request.env['omniauth.params'].any?
        @_omniauth_params = request.env['omniauth.params']
      elsif session['dta.omniauth.params'] && session['dta.omniauth.params'].any?
        @_omniauth_params ||= session.delete('dta.omniauth.params')
        @_omniauth_params
      elsif params['omniauth_window_type']
        @_omniauth_params = params.slice('omniauth_window_type', 'auth_origin_url', 'resource_class', 'origin')
      else
        @_omniauth_params = {}
      end
    end
    @_omniauth_params
  end

  # セッションから認証データ削除 & @_auth_hashに代入
  def auth_hash
    @_auth_hash ||= session.delete('dta.omniauth.auth')
    @_auth_hash
  end

  # # トークン生成
  def set_token_on_resource
    @config = omniauth_params['config_name']
    @token  = @resource.create_token
  end

  # 認証パラメーター生成
  def create_auth_params
    @auth_params = {
      auth_token: @token.token,
      client_id:  @token.client,
      id:         @resource.id,
      uid:        @resource.uid,
      expiry:     @token.expiry,
      config:     @config
    }
    @auth_params.merge!(oauth_registration: true) if @oauth_registration
    @auth_params
  end

  def get_redirect_route(devise_mapping)
    p "get_redirect_route"
    path = "#{Devise.mappings[devise_mapping.to_sym].fullpath}#{params[:provider]}/callback"
    klass = request.scheme == 'https' ? URI::HTTPS : URI::HTTP
    redirect_route = klass.build(host: request.host, port: request.port, path: path).to_s
  end

  # ユーザー情報変更する
  def assign_provider_attrs(user, auth_hash)
    p "assign_provider_attrs"
    case auth_hash['provider']
    when 'twitter'
      user.assign_attributes({
        nickname: auth_hash['info']['nickname'],
        name: auth_hash['info']['name'],
        image: auth_hash['info']['image'],
        email: auth_hash['info']['email']
      })
    when 'line'
      user.assign_attributes({
        # nickname: auth_hash['info']['nickname'],
        name: auth_hash['info']['name'],
        image: auth_hash['info']['image'],
        # email: auth_hash['info']['email']
      })
    else
      super
    end
  end

  def render_data_or_redirect(message, data, user_data = {})
    if ['inAppBrowser', 'newWindow'].include?(omniauth_window_type)
      render_data(message, user_data.merge(data))

    elsif auth_origin_url # default to same-window implementation, which forwards back to auth_origin_url
      # build and redirect to destination url
      redirect_to DeviseTokenAuth::Url.generate(auth_origin_url, data.merge(blank: true))
    else
      fallback_render data[:error] || 'An error occurred'
    end
  end

  def get_resource_from_auth_hash
    # uidとproviderをusersテーブルから検索なければ、新規レコード追加
    @resource = resource_class.where(
      uid: auth_hash['uid'],
      provider: auth_hash['provider']
    ).first_or_initialize

    # 新しいレコードの場合
    if @resource.new_record?
      # ランダムなパスワード作成&追加
      handle_new_resource
    end

    assign_provider_attrs(@resource, auth_hash)

    # 追加のパラメーターがあったら追加?
    if assign_whitelisted_params?
      extra_params = whitelisted_params
      @resource.assign_attributes(extra_params) if extra_params
    end
    
    @resource
  end

  # deviseパラメータサニタイザから許可されたパラメータを出力?
  def whitelisted_params
    whitelist = params_for_resource(:sign_up)

    whitelist.inject({}) do |coll, key|
      param = omniauth_params[key.to_s]
      coll[key] = param if param
      coll
    end
  end

end
