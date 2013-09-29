
OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '713183305362701', '93960ef701beae1c93a71bb3ee23dfbe'
end