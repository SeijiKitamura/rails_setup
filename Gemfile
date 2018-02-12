source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails',                   '5.0.1'
gem 'bcrypt',                  '3.1.11'
gem 'faker',                   '1.6.6'
gem 'carrierwave',             '1.0.0'
gem 'mini_magick',             '4.5.1'
gem 'fog',                     '1.38.0'
gem 'will_paginate',           '3.1.0'
gem 'bootstrap-will_paginate', '0.0.10'
gem 'bootstrap-sass',          '3.3.6'
gem 'puma'
gem 'sass-rails',              '5.0.6'
gem 'uglifier',                '3.0.0'
gem 'coffee-rails',            '4.2.1'
gem 'jquery-rails',            '4.1.1'
gem 'turbolinks',              '5.0.1'
gem 'jbuilder',                '2.4.1'
gem 'slim-rails'
gem 'lazyload-rails'
gem 'sqlite3',               '1.3.11'
gem 'therubyracer',platforms: :ruby
gem 'listen',                '3.0.8'
gem 'whenever', :require => false

group :development, :test do
  gem 'hirb'
  gem 'hirb-unicode'
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'byebug',                '9.0.0', platform: :mri
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'spring',                '1.7.2'
  gem 'spring-watcher-listen', '2.0.0'
end

group :development do
  gem 'web-console',           '3.1.1'
end

group :test do
  gem 'minitest',                 '5.10.1'
  gem 'rails-controller-testing', '0.1.1'
  gem 'minitest-reporters',       '1.1.9'
  gem 'guard',                    '2.13.0'
  gem 'guard-minitest',           '2.4.4'
end

