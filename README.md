# Redis stores for ActionPack

__`redis-actionpack`__ provides a session store for __ActionPack__, specifically for __ActionDispatch__. See the main [redis-store readme](https://github.com/redis-store/redis-store) for general guidelines.

For guidelines on using our underlying cache store, see the main [redis-store readme](https://github.com/redis-store/redis-store).

For information on how to use this library in a Rails app, see the [documentation for redis-rails](https://github.com/redis-store/redis-rails).

If, for some reason, you're using `ActionDispatch` and not in a Rails app, read on to learn how to install/use this gem by itself!

## Installation

```ruby
# Gemfile
gem 'redis-actionpack'
```

## Usage

If you are using redis-store with Rails, consider using the [redis-rails gem](https://github.com/redis-store/redis-rails) instead. For standalone usage:

```ruby
ActionController::Base.cache_store = ActionDispatch::Session::RedisStore.new
```

## Running tests

```shell
gem install bundler
git clone git://github.com/redis-store/redis-actionpack.git
cd redis-actionpack
bundle install
bundle exec rake
```

If you are on **Snow Leopard** you have to run `env ARCHFLAGS="-arch x86_64" bundle exec rake`

## Status

[![Gem Version](https://badge.fury.io/rb/redis-actionpack.svg)](http://badge.fury.io/rb/redis-actionpack) 
[![Build Status](https://secure.travis-ci.org/redis-store/redis-actionpack.svg?branch=master)](http://travis-ci.org/redis-store/redis-actionpack?branch=master) 
[![Code Climate](https://codeclimate.com/github/redis-store/redis-actionpack.svg)](https://codeclimate.com/github/redis-store/redis-actionpack)

## Copyright

2009 - 2013 Luca Guidi - [http://lucaguidi.com](http://lucaguidi.com), released under the MIT license
