require "test_helper"

class BooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(username: "tester", email: "tester@example.com",
                           password: "password", password_confirmation: "password")
    @book = Book.create!(title: "Example Book", author: "Author Name", isbn: "1234567890")
    post login_path, params: { email: @user.email, password: "password" }
  end

  test "should get index" do
    get books_path
    assert_response :success
    assert_select "h1", "Books"
  end

  test "should show book" do
    get book_path(@book)
    assert_response :success
    assert_select "h1", @book.title
  end
end
