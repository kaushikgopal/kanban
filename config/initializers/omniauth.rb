OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, "6QesKGHEoJ4Hn5ksF2u3A", "t7azpAgiIOasQi5ypKXRAjN2WLLMnjexJrjDdZFp0"
end