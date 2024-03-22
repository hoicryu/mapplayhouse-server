source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.5"

gem "bcrypt", "~> 3.1.7"
gem "bootsnap", ">= 1.4.2", require: false
gem "httparty", "~> 0.16.2"
gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 4.1"
gem "rack-cors"
gem "rails", "~> 6.0.3", ">= 6.0.3.3"
gem "rails-i18n"
gem "redis", "~> 4.0"

group :development, :test do
  gem "hirb"
  gem "hirb-unicode"
  gem "pry-byebug", platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem "capistrano", "~> 3.7", ">= 3.7.1"
  gem "capistrano-passenger", "~> 0.2.0"
  gem "capistrano-rails", "~> 1.2"
  gem "capistrano-rbenv", "~> 2.1"
  gem "listen", "~> 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

gem "activeadmin"
gem "activeadmin_addons"
gem "activeadmin_reorderable"
gem "active_material", github: "vigetlabs/active_material"
gem "acts_as_list"
gem "carrierwave"
gem "devise"
gem "faker"
gem "geokit"
gem "geokit-rails"
gem "impressionist", github: "insomenia/impressionist"
gem "jwt"
gem "kaminari"
gem "mini_magick"
gem "ordinare"
gem "panko_serializer"
gem "pry-rails"
gem "pundit"
gem "ransack"
gem "sass-rails"
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
gem "versionist"
gem "web-console", github: "insomenia-seongjun/web-console"

gem "aws-sdk-cognitoidentity"
gem "aws-sdk-cognitoidentityprovider"
gem "aws-sdk-core"
gem "aws-sdk-s3"
gem "fog-aws"