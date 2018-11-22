require 'test_helper'

class AuthenticationControllerTest < ActionDispatch::IntegrationTest
  setup do
    @valid_user = users(:one)
    @invalid_user = users(:two)
  end

  test "auth request returns :ok for valid user" do
    # post to auth endpoint
    sign_in_as(@valid_user)
    # post authenticate_url, params: {email: @valid_user.email, password: "foobar12"}
    assert_response :success
    assert_not_nil @response.body
  end

  test "auth request doesn't allow invalid user" do
    sign_in_as(@invalid_user)
    assert_response :unauthorized
  end

end
