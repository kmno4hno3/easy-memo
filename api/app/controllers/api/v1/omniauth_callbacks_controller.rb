class Api::V1::OmniauthCallbacksController < DeviseTokenAuth::OmniauthCallbacksController
  skip_before_action :skip_session
  before_action :test

  def test
    p "テスト"
  end

  def redirect_callbacks
    p "リダイレクト"
    super
  end

  def omniauth_success
    p "成功"
    super
  end

  def omniauth_failure
    p "失敗"
    super
  end

  protected
  def get_redirect_route(devise_mapping)
    p "get_redirect_route"
    path = "#{Devise.mappings[devise_mapping.to_sym].fullpath}#{params[:provider]}/callback"
    p path
      klass = request.scheme == 'https' ? URI::HTTPS : URI::HTTP
      redirect_route = klass.build(host: request.host, port: request.port, path: path).to_s
    # super
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

end
