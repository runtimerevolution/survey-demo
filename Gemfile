source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.7'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Use jquery as the JavaScript library
gem 'jquery-rails', '~> 4.3'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'twitter-bootstrap-rails', '~> 4.0'
gem 'kaminari', '~> 1.2' # pagination
gem 'client_side_validations', github: 'DavyJonesLocker/client_side_validations' # validates forms on the client side
gem 'newrelic_rpm', '~> 6.9' # new relic instrumentation (heroku plugin)

gem 'survey', '2.0.0' # our gem

group :development, :test do
  gem 'better_errors', '~> 2.6' # improves the error page
  gem 'binding_of_caller', '~> 0.8.0'  # used by better_errors
  gem 'awesome_print', '~> 1.8'  # awesome variable print

  gem 'pry-rails', '~> 0.3.9'
  gem 'pry-byebug', '~> 3.9'
  gem 'pry-rescue', '~> 1.5' # use rescue before a rails command, and if an exception is trigger you will be loaded into a pry session
  gem 'pry-stack_explorer', '~> 0.4.9.3' # explore stack calls with up and down

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '>= 3.3.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'rails_12factor', group: :production

ruby "2.5.0"
