Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV[' 355175857959207'], ENV['dcdba76e51398ba3752784039eccfc12']
end
