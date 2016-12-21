source 'https://rubygems.org'

gem 'pg'

gem 'rails', '~> 5.0.0'

# Store sessions in the database
gem 'activerecord-session_store', '~> 1.0.0'

gem 'publify_amazon_sidebar', '~> 9.0.0.pre1'
gem 'publify_core', '~> 9.0.0.pre4'
gem 'publify_textfilter_code', '~> 9.0.0.pre1'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

gem 'airbrake', '~> 5.6.1'

# Needed for the lightbox and flickr text filters
gem 'flickraw', '~> 0.9.8'
gem 'flickraw-cached', '20120701'

gem 'non-stupid-digest-assets', '~> 1.0'
gem 'rake', '~> 12.0'
gem 'lograge', '~> 0.4.1'
gem 'dotenv-rails', '~> 2.1.1'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', '~> 9.0'

  gem 'capybara', '~> 2.7'
  gem 'factory_girl', '~> 4.5'
  gem 'i18n-tasks', '~> 0.9.1', require: false
  gem 'pry', '~> 0.10.3'
  gem 'pry-rails', '~> 0.3.4'
  gem 'rspec-rails', '~> 3.4'
  gem 'rubocop', '~> 0.46.0', require: false
  gem 'simplecov', '~> 0.12.0', require: false
end

group :development do
  gem 'better_errors', '~> 2.1.1'
  gem 'binding_of_caller', '~> 0.7.2'

  gem 'guard-rspec'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '~> 2.0.0'
  gem 'spring-commands-cucumber', '~> 1.0'
  gem 'spring-commands-rspec', '~> 1.0'

  gem 'thin', '~> 1.6'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 3.0' if RUBY_VERSION >= '2.2.2'
end

group :development do
  gem 'capistrano', '~> 3.7.1', require: false
  gem 'capistrano-rails',   '~> 1.1', require: false
  gem 'capistrano-bundler', '~> 1.1', require: false
  gem 'capistrano-passenger', '0.2.0', require: false
  gem 'capistrano-dotenv-tasks', '0.1.3', require: false
end

group :test do
  gem 'codeclimate-test-reporter', '~> 1.0.3', require: false
  gem 'rails-controller-testing'
  gem 'sqlite3'
end

# Install gems from each theme
Dir.glob(File.join(File.dirname(__FILE__), 'themes', '**', 'Gemfile')) do |gemfile|
  eval(IO.read(gemfile), binding)
end
