Rails.application.configure do
  config.lograge.custom_options = lambda do |event|
    params = event.payload[:params].except('controller', 'action', 'utf8', 'authenticity_token')
    params.any? ? { 'params' => params } : {}
  end
end
