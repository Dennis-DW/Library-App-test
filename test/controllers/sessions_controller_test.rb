require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(username: "tester", email: "tester@example.com",
                           password: "password", password_confirmation: "password")
  end

  test "should get login page" do
    get login_path
    assert_response :success
    assert_select "h1", "Login"
  end

  test "should log in with valid credentials" do
    post login_path, params: { email: @user.email, password: "password" }
    assert_redirected_to books_path
    follow_redirect!
    assert_match /Logged in successfully/, response.body
  end

  test "should not log in with invalid credentials" do
    post login_path, params: { email: @user.email, password: "wrongpassword" }
    assert_response :success
    # assert_select "p.alert", /Invalid email or password/
  end

  test "should log out" do
    post login_path, params: { email: @user.email, password: "password" }
    delete logout_path
    assert_redirected_to login_path
    follow_redirect!
    assert_match /Logged out successfully/, response.body
  end
end
