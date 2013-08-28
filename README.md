# Redis stores for ActionPack

__`redis-actionpack`__ provides a session store for __ActionPack__, specifically for __ActionDispatch__. See the main [redis-store readme](https://github.com/redis-store/redis-store) for general guidelines.

## Installation

```ruby
# Gemfile
gem 'redis-actionpack'
```

## Usage

If you are using redis-store with Rails, consider using the [redis-rails gem](https://github.com/redis-store/redis-rails) instead.
For standalone usage:

```ruby
ActionController::Base.cache_store = ActionDispatch::Session::RedisSessionStore.new
```

## Running tests

```shell
gem install bundler
git clone git://github.com/redis-store/redis-actionpack.git
cd redis-actionpack
git checkout -t origin/3.2.x
bundle install
bundle exec rake
```

If you are on **Snow Leopard** you have to run `env ARCHFLAGS="-arch x86_64" bundle exec rake`

## Status

[![Build Status](https://secure.travis-ci.org/redis-store/redis-actionpack.png?branch=3.2.x)](http://travis-ci.org/jodosha/redis-actionpack?branch=3.2.x)

## Copyright

2009 - 2013 Luca Guidi - [http://lucaguidi.com](http://lucaguidi.com), released under the MIT license
