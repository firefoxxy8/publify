Rails.application.configure do
  config.lograge.custom_options = lambda do |event|
    params = event.payload[:params].except('controller', 'action')
    { 'params' => params }
  end
end
