# frozen_string_literal: true

require_relative 'lib/redis/actionpack/version'

Gem::Specification.new do |s|
  s.name        = 'redis-actionpack'
  s.version     = Redis::ActionPack::VERSION
  s.authors     = ['Luca Guidi']
  s.email       = ['me@lucaguidi.com']
  s.homepage    = 'https://redis-store.org/redis-actionpack/'
  s.summary     = 'Redis session store for ActionPack'
  s.description = "#{s.summary}. Used for storing the Rails session in Redis."
  s.license     = 'MIT'
  s.metadata    = {
    'source_code_uri' => 'https://github.com/redis-store/redis-actionpack'
  }

  s.required_ruby_version = '>= 2.7.0'

  s.files = `git ls-files`.split("\n")

  s.add_dependency 'actionpack',  '>= 5'
  s.add_dependency 'redis-rack',  '>= 2.1.0', '< 4'
  s.add_dependency 'redis-store', '>= 1.1.0', '< 2'
end
