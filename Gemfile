source 'https://rubygems.org'

gem 'pg'

gem 'rails', '~> 4.2.5'

gem 'publify_core', '~> 9.0.0.pre1'
gem 'publify_amazon_sidebar', '~> 9.0.0.pre1'
gem 'publify_textfilter_code', '~> 9.0.0.pre1'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

gem 'airbrake', '~> 4.3'

# Needed for the lightbox and flickr text filters
gem 'flickraw-cached', '20120701'
gem 'flickraw', '~> 0.9.8'

gem 'non-stupid-digest-assets', '~> 1.0'
gem 'rake', '~> 11.1'
gem 'lograge', '~> 0.3.4'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', '~> 9.0'

  gem 'factory_girl', '~> 4.5'
  gem 'capybara', '~> 2.7'
  gem 'rspec-rails', '~> 3.4'
  gem 'simplecov', '~> 0.12.0', require: false
  gem 'pry-rails', '~> 0.3.4'
  gem 'pry', '~> 0.10.3'

  gem 'rubocop', '~> 0.41.0', require: false
  gem 'i18n-tasks', '~> 0.9.1', require: false
end

group :development do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '~> 1.7'
  gem 'spring-commands-rspec', '~> 1.0'
  gem 'spring-commands-cucumber', '~> 1.0'

  gem 'thin', '~> 1.6'
  gem 'better_errors', '~> 2.1.1'
  gem 'binding_of_caller', '~> 0.7.2'
  gem 'quiet_assets', '~> 1.1'
  gem 'guard-rspec'
end

group :development do
  gem 'capistrano', '~> 3.4.0', require: false
  gem 'capistrano-rails',   '~> 1.1', require: false
  gem 'capistrano-bundler', '~> 1.1', require: false
  gem 'capistrano-passenger', '0.0.1', require: false
end

group :test do
  gem 'codeclimate-test-reporter', '~> 0.6.0', require: nil
  gem 'sqlite3'
end

# Install gems from each theme
Dir.glob(File.join(File.dirname(__FILE__), 'themes', '**', 'Gemfile')) do |gemfile|
  eval(IO.read(gemfile), binding)
end
