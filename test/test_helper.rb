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

  # Log in as a particular user.
  def log_in_as(user)
    session[:user_id] = user.id
  end
end

class ActionDispatch::IntegrationTest
  # Log in as a particular user.
  def log_in_as(user, password: 'password', remember_me: '1')
    post(
      login_path,
      params: {
        session: {
          email: user.email,
          password: password,
          remember_me: remember_me
        }
      }
    )
  end

  # Remembers a user in a persistent session.
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
end
