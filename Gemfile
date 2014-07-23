source 'https://rubygems.org'


# Core
gem 'rails', '4.1.1'
gem 'pg'
gem 'hstore_accessor'


# Assets
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'


# User Interface
gem 'navigasmic'
gem 'kaminari'
gem 'country_select'
gem 'pdfjs-rails', git: 'git://github.com/Empact/pdfjs-rails'


# Files
gem 'carrierwave'
gem 'cloudinary'
gem 'fog'
gem 'pdfkit'
gem 'phantomjs'


# Conversion
gem 'geocoder'
gem 'money-rails'


# Background Queue
gem 'resque', '~> 1.22.0', require: 'resque/server'


# Search
gem 'pg_search'


# Docs
gem 'sdoc', '~> 0.4.0',     group: :doc


# Development
group :development do
  gem 'spring'
  gem 'better_errors'
  gem 'binding_of_caller'
end


# Heroku
group :production do
  gem 'wkhtmltopdf-heroku', git: 'git://github.com/pallymore/wkhtmltopdf-heroku'
  gem 'rails_12factor'
  gem 'heroku_rails_deflate'
end

ruby "2.1.1"