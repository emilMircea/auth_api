ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module SignInHelper
  def sign_in_as(user)
    post authenticate_url, params: {email: user.email, password: "foobar12"}, xhr: true
    token_hash = JSON.parse @response.body
    @valid_token = token_hash["auth_token"]
    @valid_token
  end
end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  include SignInHelper
end
