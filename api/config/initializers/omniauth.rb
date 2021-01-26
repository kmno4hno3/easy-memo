Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV.fetch("TWITTER_API_KEY"), ENV.fetch("TWITTER_API_KEY_SECRET"), callback_url: "https://2eacfd1b088a.ngrok.io/omniauth/twitter/callback"
end