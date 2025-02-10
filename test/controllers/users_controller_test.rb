require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new user registration page" do
    get signup_path
    assert_response :success
    assert_select "h1", "Sign Up"
  end

  test "should create user" do
    assert_difference "User.count", 1 do
      post users_path, params: { user: { username: "newuser",
                                          email: "newuser@example.com",
                                          password: "password",
                                          password_confirmation: "password" } }
    end
    follow_redirect!
    assert_match /Account created successfully/, response.body
  end

  test "should show profile when logged in" do
    user = User.create!(username: "tester", email: "tester@example.com",
                        password: "password", password_confirmation: "password")
    post login_path, params: { email: user.email, password: "password" }
    get user_path(user)
    assert_response :success
    assert_select "h1", /Profile:/
  end

  test "should redirect profile when not logged in" do
    user = User.create!(username: "tester", email: "tester@example.com",
                        password: "password", password_confirmation: "password")
    get user_path(user)
    assert_redirected_to login_path
  end
end
