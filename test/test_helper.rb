require "simplecov"

ENV['RAILS_ENV'] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/reporters"
require "minitest/mock"
Minitest::Reporters.use!
Dir[Rails.root.join("test/support/**/*.rb")].each { |file| require file }

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  include ApplicationHelper

  # Returns true if a test user is logged in.
  def logged_in_user?
    session[:user_id].present?
  end
end
