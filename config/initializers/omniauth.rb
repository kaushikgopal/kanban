OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, "6QesKGHEoJ4Hn5ksF2u3A", "t7azpAgiIOasQi5ypKXRAjN2WLLMnjexJrjDdZFp0"
  provider :facebook, "184347648383728", "69e5a52e537cd513f1dfb45705ab88a6"#, {:client_options => {:ssl => {:ca_path => "/Users/kaush/"}}}
  provider :github, "47c0132e5af6f9c4d933", "39f3f36ebf3e0b967a7a9ab2e243edbc794597e0"
end