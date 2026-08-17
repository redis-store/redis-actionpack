# frozen_string_literal: true

appraise 'rails_5.0' do
  gem 'redis-store'
  gem 'redis-rack'
  gem 'actionpack', '~> 5.0.0'
  gem 'tzinfo', '~> 1.2'
end

appraise 'rails_5.1' do
  gem 'redis-store'
  gem 'redis-rack'
  gem 'actionpack', '~> 5.1.0'
  gem 'tzinfo', '~> 1.2'
end

appraise 'rails_5.2' do
  gem 'redis-store'
  gem 'redis-rack'
  gem 'actionpack', '~> 5.2.0'
  gem 'tzinfo', '~> 1.2'
end

appraise 'rails_6.0' do
  gem 'redis-store'
  gem 'redis-rack'
  gem 'actionpack', '~> 6.0.0'
  gem 'tzinfo', '~> 1.2'

  # ActiveSupport <= 6.1 uses Logger without requiring it, relying on
  # concurrent-ruby to do so. concurrent-ruby 1.3.5 dropped that require.
  gem 'concurrent-ruby', '< 1.3.5'
end

appraise 'rails_6.1' do
  gem 'redis-store'
  gem 'redis-rack'
  gem 'actionpack', '~> 6.1.0'
  gem 'concurrent-ruby', '< 1.3.5'
end

appraise 'rails_7.0' do
  gem 'redis-store'
  gem 'redis-rack'
  gem 'actionpack', '~> 7.0.0'
end

appraise 'rails_7.1' do
  gem 'redis-store'
  gem 'redis-rack'
  gem 'actionpack', '~> 7.1.0'
end

appraise 'rails_7.2' do
  gem 'redis-store'
  gem 'redis-rack'
  gem 'actionpack', '~> 7.2.0'
end

appraise 'rails_8.0' do
  gem 'redis-store'
  gem 'redis-rack'
  gem 'actionpack', '~> 8.0.0'
end
