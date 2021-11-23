require 'test_helper'

class AccountControllerTest < ActionDispatch::IntegrationTest
  test "should get sign_up" do
    get account_sign_up_url
    assert_response :success
  end

  test "should get login" do
    get account_login_url
    assert_response :success
  end

end
