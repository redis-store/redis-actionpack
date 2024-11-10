require 'bundler/setup'
require 'minitest/autorun'
require 'active_support'
require 'active_support/core_ext/numeric/time'

ENV["RAILS_ENV"] = "test"
require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"

Rails.backtrace_cleaner.remove_silencers!


if Gem::Version.new(ActiveSupport.version) > Gem::Version.new('7.0')
  # See: https://github.com/rails/rails/blob/v7.0.0/actionpack/test/abstract_unit.rb#L161
  def with_autoload_path(path)
    path = File.join(__dir__, "fixtures", path)
    Zeitwerk.with_loader do |loader|
      loader.push_dir(path)
      loader.setup
      yield
    ensure
      loader.unload
    end
  end
else
  # See: https://github.com/rails/rails/blob/v6.1.0/actionpack/test/abstract_unit.rb#L162
  def with_autoload_path(path)
    path = File.join(File.dirname(__FILE__), "fixtures", path)
    if ActiveSupport::Dependencies.autoload_paths.include?(path)
      yield
    else
      begin
        ActiveSupport::Dependencies.autoload_paths << path
        yield
      ensure
        ActiveSupport::Dependencies.autoload_paths.reject! {|p| p == path}
        ActiveSupport::Dependencies.clear
      end
    end
  end
end
