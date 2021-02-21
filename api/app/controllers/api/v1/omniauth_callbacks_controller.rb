class Api::V1::OmniauthCallbacksController < DeviseTokenAuth::OmniauthCallbacksController
  skip_before_action :skip_session
  before_action :test

  def test
    p "テスト"
  end

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

    # 動作確認用にユーザ情報を保存できたらjsonをそのまま返す処理
    if @resource.save!
      # update_token_authをつけることでレスポンスヘッダーに認証情報を付与できる。
      update_auth_header
      yield @resource if block_given?
      render json: @resource, status: :ok
    else
      render json: { message: "failed to login" }, status: 500
    end

    # yield @resource if block_given?
    # render_data_or_redirect('deliverCredentials', @auth_params.as_json, @resource.as_json)
  end

  def omniauth_failure
    p "失敗"
    super
  end

  protected
  def get_redirect_route(devise_mapping)
    p "get_redirect_route"
    p devise_mapping
    path = "#{Devise.mappings[devise_mapping.to_sym].fullpath}#{params[:provider]}/callback"
    p path
    klass = request.scheme == 'https' ? URI::HTTPS : URI::HTTP
    redirect_route = klass.build(host: request.host, port: request.port, path: path).to_s
  end

  def assign_provider_attrs(user, auth_hash)
    p "1"
    case auth_hash['provider']
    when 'twitter'
      user.assign_attributes({
        nickname: auth_hash['info']['nickname'],
        name: auth_hash['info']['name'],
        image: auth_hash['info']['image'],
        email: auth_hash['info']['email']
      })
    else
      p "2"
      super
    end
  end

  def render_data_or_redirect(message, data, user_data = {})
    # We handle inAppBrowser and newWindow the same, but it is nice
    # to support values in case people need custom implementations for each case
    # (For example, nbrustein does not allow new users to be created if logging in with
    # an inAppBrowser)
    #
    # See app/views/devise_token_auth/omniauth_external_window.html.erb to understand
    # why we can handle these both the same.  The view is setup to handle both cases
    # at the same time.
    if ['inAppBrowser', 'newWindow'].include?(omniauth_window_type)
      render_data(message, user_data.merge(data))

    elsif auth_origin_url # default to same-window implementation, which forwards back to auth_origin_url

      # build and redirect to destination url
      redirect_to DeviseTokenAuth::Url.generate(auth_origin_url, data.merge(blank: true))
    else

      # there SHOULD always be an auth_origin_url, but if someone does something silly
      # like coming straight to this url or refreshing the page at the wrong time, there may not be one.
      # In that case, just render in plain text the error message if there is one or otherwise
      # a generic message.
      fallback_render data[:error] || 'An error occurred'
    end
  end

  def get_resource_from_auth_hash
    # find or create user by provider and provider uid
    @resource = resource_class.where(
      uid: auth_hash['uid'],
      provider: auth_hash['provider']
    ).first_or_initialize

    if @resource.new_record?
      handle_new_resource
    end

    # sync user info with provider, update/generate auth token
    assign_provider_attrs(@resource, auth_hash)

    # assign any additional (whitelisted) attributes
    if assign_whitelisted_params?
      extra_params = whitelisted_params
      @resource.assign_attributes(extra_params) if extra_params
    end

    @resource
  end

end
