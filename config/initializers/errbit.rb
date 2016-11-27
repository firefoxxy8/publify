Airbrake.configure do |config|
  config.environment = Rails.env
  config.ignore_environments = [:test, :development]
  config.project_key =  '1451e93f0e3b52247c08ed94d1b88f84'
  config.project_id = 23
end
