source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'rails', '~> 6.1.4'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'bootsnap', '>= 1.4.4', require: false

gem 'devise_token_auth', '~> 1.1.4'

gem 'jbuilder', '~> 2.10.1'


group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 4.0.1'
  gem 'factory_bot_rails'
  gem 'shoulda-matchers', '~> 4.0'
  gem 'faker'
  gem "database_cleaner"
end

group :development do
  gem "annotate"
  gem 'listen', '~> 3.3'
  gem 'spring'
end
