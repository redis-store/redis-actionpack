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

If you are using redis-store with Rails, head on over to the
[redis-rails README](https://github.com/redis-store/redis-rails#session-storage) to
learn how to integrate this gem into your Rails application.

For standalone usage:

```ruby
ActionController::Base.session_store = :redis_store,
  servers: %w(redis://localhost:6379/0/session),
  expire_after: 90.minutes,
  key: '_my_application_session',
  threadsafe: false,
  secure: true
```

A brief run-down of these options...

- **servers** is an Array of Redis server URLs that we will attempt to find
  data from.<br>
  The "session" at the end of the URL is used as the prefix of the key in the redis server.<br>
  you can use another expression as below.
  ```
  servers: [redis://localhost:6379/0, :namespace => 'session'],
  ```
- **expire_after** is the default TTL of session keys. This is also set
  as the expiry time of any cookies generated by the session store.
- **key** is the name of the cookie on the client side
- **threadsafe** is for applications that run on multiple instances. Set
  this to `false` if you want to disable the global mutex lock on
  session data. It's `true` by default, meaning the mutex will be
  enabled.
- **secure** ensures HTTP cookies are transferred from server to client
  on a secure (HTTPS) connection

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
