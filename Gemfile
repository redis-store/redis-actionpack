source 'https://rubygems.org'
gemspec

if ::File.directory?(gem_path = '../redis-store')
  gem 'redis-store', '~> 1.1', path: gem_path
end

if ::File.directory?(gem_path = '../redis-rack')
  gem 'redis-rack', '~> 2.0.0', path: gem_path
end
