source 'https://rubygems.org'
gemspec :path => './../..'

gem 'redis-store', github: 'redis-store/redis-store'
#if ::File.directory?(gem_path = '../redis-store')
#  gem 'redis-store', '~> 1.1.0', path: gem_path
#end

gem 'redis-rack', github: 'redis-store/redis-rack'
#if ::File.directory?(gem_path = '../redis-rack')
#  gem 'redis-rack', '~> 1.5.0', path: gem_path
#end

gem 'rails', '5.0.0.beta3'

gem 'minitest-spec-rails', '~> 5.3.0'

