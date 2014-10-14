source 'https://rubygems.org'


# Core
gem 'rails', '4.1.4'
gem 'pg'
gem 'unicorn'
gem 'hstore_accessor'
gem 'rails_config'
gem 'rails_admin'
gem 'figaro', '~> 1.0.0.rc1'


# Users
gem 'devise'
gem 'paper_trail', '~> 3.0.3'
gem 'public_activity'


# Assets
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'gon'


# User Interface
gem 'navigasmic', git: 'git://github.com/jejacks0n/navigasmic'
gem 'kaminari'
gem 'country_select'
gem 'indefinite_article'
gem 'pdfjs-rails', git: 'git://github.com/Empact/pdfjs-rails'


# Files
gem 'carrierwave'
gem 'carrierwave_direct'
gem 'aws-sdk'
gem 'cloudinary'
gem 'fog'
gem 'pdfkit'
gem 'phantomjs'


# APIs
gem 'geocoder'
gem 'money-rails'
gem 'googlebooks'
gem 'embedly'
gem 'alchemy-api-rb', :require => 'alchemy_api'


# Background Queue
gem 'resque', '~> 1.22.0', require: 'resque/server'
gem 'resque-sliders'
#gem 'resque-web', require: 'resque_web'


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