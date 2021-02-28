Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :twitter, ENV.fetch("TWITTER_API_KEY"), ENV.fetch("TWITTER_API_KEY_SECRET"), callback_url: "https://307cce780594..io/omniauth/twitter/callback"
  provider :twitter, ENV.fetch("TWITTER_API_KEY"), ENV.fetch("TWITTER_API_KEY_SECRET")
  provider :line, ENV.fetch("LINE_LOGIN_CHANNEL_ID"), ENV.fetch("LINE_LOGIN_CHANNEL_SECRET")
end