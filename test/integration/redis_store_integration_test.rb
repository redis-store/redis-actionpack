require 'test_helper'

class RedisStoreIntegrationTest < ::ActionDispatch::IntegrationTest
  SessionKey = '_session_id'
  SessionSecret = 'b3c631c314c0bbca50c1b2843150fe33'

  test "reads the data" do
    with_test_route_set do
      get '/set_session_value'
      response.must_be :success?
      cookies['_session_id'].wont_be_nil

      get '/get_session_value'
      response.must_be :success?
      response.body.must_equal 'foo: "bar"'
    end
  end

  test "should get nil session value" do
    with_test_route_set do
      get '/get_session_value'
      response.must_be :success?
      response.body.must_equal 'foo: nil'
    end
  end

  test "should delete the data after session reset" do
    with_test_route_set do
      get '/set_session_value'
      response.must_be :success?
      cookies['_session_id'].wont_be_nil
      session_cookie = cookies.send(:hash_for)['_session_id']

      get '/call_reset_session'
      response.must_be :success?
      headers['Set-Cookie'].wont_equal []

      cookies << session_cookie

      get '/get_session_value'
      response.must_be :success?
      response.body.must_equal 'foo: nil'
    end
  end

  test "should not send cookies on write, not read" do
    with_test_route_set do
      get '/get_session_value'
      response.must_be :success?
      response.body.must_equal 'foo: nil'
      cookies['_session_id'].must_be_nil
    end
  end

  test "should set session value after session reset" do
    with_test_route_set do
      get '/set_session_value'
      response.must_be :success?
      cookies['_session_id'].wont_be_nil
      session_id = cookies['_session_id']

      get '/call_reset_session'
      response.must_be :success?
      headers['Set-Cookie'].wont_equal []

      get '/get_session_value'
      response.must_be :success?
      response.body.must_equal 'foo: nil'

      get '/get_session_id'
      response.must_be :success?
      response.body.wont_equal session_id
    end
  end

  test "should be able to read session id without accessing the session hash" do
    with_test_route_set do
      get '/set_session_value'
      response.must_be :success?
      cookies['_session_id'].wont_be_nil
      session_id = cookies['_session_id']

      get '/get_session_id'
      response.must_be :success?
      response.body.must_equal session_id
    end
  end

  test "should auto-load unloaded class" do
    with_test_route_set do
      with_autoload_path "session_autoload_test" do
        get '/set_serialized_session_value'
        response.must_be :success?
        cookies['_session_id'].wont_be_nil
      end

      with_autoload_path "session_autoload_test" do
        get '/get_session_id'
        assert_response :success
      end

      with_autoload_path "session_autoload_test" do
        get '/get_session_value'
        response.must_be :success?
        response.body.must_equal 'foo: #<SessionAutoloadTest::Foo bar:"baz">'
      end
    end
  end

  test "should not resend the cookie again if session_id cookie is already exists" do
    with_test_route_set do
      get '/set_session_value'
      response.must_be :success?
      cookies['_session_id'].wont_be_nil

      get '/get_session_value'
      response.must_be :success?
      headers['Set-Cookie'].must_be_nil
    end
  end

  test "should prevent session fixation" do
    with_test_route_set do
      get '/get_session_value'
      response.must_be :success?
      response.body.must_equal 'foo: nil'
      session_id = cookies['_session_id']

      reset!

      get '/set_session_value', :_session_id => session_id
      response.must_be :success?
      cookies['_session_id'].wont_equal session_id
    end
  end

  test "should write the data with expiration time" do
    with_test_route_set do
      get '/set_session_value_with_expiry'
      response.must_be :success?

      get '/get_session_value'
      response.must_be :success?
      response.body.must_equal 'foo: "bar"'

      sleep 1

      get '/get_session_value'
      response.must_be :success?
      response.body.must_equal 'foo: nil'
    end
  end

  test "session store with explicit domain" do
    with_test_route_set(:domain => "example.es") do
      get '/set_session_value'
      assert_match(/domain=example\.es/, headers['Set-Cookie'])
      headers['Set-Cookie']
    end
  end

  test "session store without domain" do
    with_test_route_set do
      get '/set_session_value'
      assert_no_match(/domain\=/, headers['Set-Cookie'])
    end
  end

  test "session store with nil domain" do
    with_test_route_set(:domain => nil) do
      get '/set_session_value'
      assert_no_match(/domain\=/, headers['Set-Cookie'])
    end
  end

  test "session store with all domains" do
    with_test_route_set(:domain => :all) do
      get '/set_session_value'
      assert_match(/domain=\.example\.com/, headers['Set-Cookie'])
    end
  end

  private

    # from actionpack/test/abstract_unit.rb
    class RoutedRackApp
      attr_reader :routes
      def initialize(routes, &blk)
        @routes = routes
        @stack = ActionDispatch::MiddlewareStack.new(&blk).build(@routes)
      end
      def call(env)
        @stack.call(env)
      end
    end

    # from actionpack/test/abstract_unit.rb
    def self.build_app(routes = nil)
      RoutedRackApp.new(routes || ActionDispatch::Routing::RouteSet.new) do |middleware|
        middleware.use ActionDispatch::DebugExceptions
        middleware.use ActionDispatch::Callbacks
        middleware.use ActionDispatch::ParamsParser
        middleware.use ActionDispatch::Cookies
        middleware.use ActionDispatch::Flash
        middleware.use Rack::Head
        yield(middleware) if block_given?
      end
    end

    # from actionpack/test/dispatch/session/cookie_store_test.rb
    def with_test_route_set(options = {})
      with_routing do |set|
        set.draw do
          get ':action', :to => ::TestController
        end
        options = { :key => SessionKey }.merge!(options)
        @app = self.class.build_app(set) do |middleware|
          middleware.use ActionDispatch::Session::RedisStore, options
        end
        yield
      end
    end
end
