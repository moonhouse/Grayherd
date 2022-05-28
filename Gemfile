source "https://rubygems.org"
ruby "2.6.3"

gem 'rails', '4.2.11.3'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'


gem 'thin'
gem 'spreadsheet'
gem "haml"
#gem 'activeadmin', '0.6.0'
gem 'activeadmin' #, github: 'activeadmin'
gem 'devise'
gem "bcrypt"
#gem "bcrypt-ruby", :require => "bcrypt"
gem 'tilt'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'coffee-rails'
  gem 'uglifier'
end

gem 'sass-rails' #, "  ~> 3.2"

gem 'jquery-rails'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :development do
  gem 'rails-dev-tweaks', '~> 1.1'
  gem 'sqlite3'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end
