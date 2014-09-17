source 'https://rubygems.org'

gem 'pg'

gem 'rails', '~> 4.1.1'
gem 'htmlentities'
gem 'bluecloth', '~> 2.1'
gem 'coderay', '~> 1.1.0'
gem 'kaminari'
gem 'RedCloth', '~> 4.2.8'
gem 'addressable', '~> 2.1', :require => 'addressable/uri'
gem 'mini_magick', '~> 3.7.0', :require => 'mini_magick'
gem 'uuidtools', '~> 2.1.1'
gem 'flickraw-cached'
gem 'rubypants', '~> 0.2.0'
gem 'rake', '~> 10.1.0'
#gem 'acts_as_list'
#gem 'acts_as_tree_rails3'
gem 'fog'
gem 'recaptcha', :require => 'recaptcha/rails', :branch => 'rails3'
gem 'carrierwave', '~> 0.10.0'
gem 'akismet', '~> 1.0'
gem 'twitter', '~> 5.6.0'

gem "jquery-rails", "~> 3.1.0"
gem "jquery-ui-rails", "~> 4.2.0"

gem 'rails_autolink', '~> 1.1.0'
gem 'dynamic_form', '~> 1.1.4'

# removed from Rails-core as Rails 4.0
gem 'actionpack-page_caching', '~> 1.0.2'
gem 'rails-observers', '~> 0.1.2'

group :assets do
  gem 'sass-rails', " ~> 4.0.3"
  gem 'coffee-rails', " ~> 4.0.1"
  gem 'uglifier'
  gem 'non-stupid-digest-assets'
  gem 'therubyracer'
end

group :development, :test do
  gem 'thin'
  gem 'factory_girl', '~> 4.2.0'
  gem 'webrat'
  gem 'rspec-rails', '~> 2.99.0'
  gem 'simplecov', :require => false
  gem 'pry-rails'
end

group :development do
  gem 'capistrano', '~> 3.0', require: false
  gem 'capistrano-rails',   '~> 1.1', require: false
  gem 'capistrano-bundler', '~> 1.1', require: false
  gem 'capistrano-passenger', require: false
end

# Install gems from each theme
Dir.glob(File.join(File.dirname(__FILE__), 'themes', '**', "Gemfile")) do |gemfile|
  eval(IO.read(gemfile), binding)
end
