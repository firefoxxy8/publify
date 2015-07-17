Airbrake.configure do |config|
  config.api_key = '1451e93f0e3b52247c08ed94d1b88f84'
  config.host    = 'errbit.matijs.net'
  config.port    = 80
  config.secure  = config.port == 443
end
