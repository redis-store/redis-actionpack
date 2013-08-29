require 'test_helper'

describe Redis::ActionPack::VERSION do
  it 'returns current version' do
    Redis::ActionPack::VERSION.must_equal '3.2.4'
  end
end
