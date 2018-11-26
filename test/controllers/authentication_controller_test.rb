require "test_helper"

class AuthenticationControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bruno = users(:bruno)
  end

  test "auth request returns :ok for valid user" do
    # post to auth endpoint
    sign_in_as(@bruno)
    assert_response :success
    assert_not_nil @response.body
  end

  test "auth request doesn't allow invalid email" do
     post authenticate_url, params: {email: 'invalid@gmail.com', password: "foobar12"}, xhr: true
    assert_response :unauthorized
  end

  test "auth request doesn't allow invalid password" do
     post authenticate_url, params: {email: @bruno.email, password: "foobar"}, xhr: true
    assert_response :unauthorized
  end
end
