require "test_helper"

class BorrowingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(username: "tester", email: "tester@example.com",
                           password: "password", password_confirmation: "password")
    @book = Book.create!(title: "Example Book", author: "Author Name", isbn: "1234567890")
    post login_path, params: { email: @user.email, password: "password" }
    @borrowing = Borrowing.create!(user: @user, book: @book)
  end

  test "should create borrowing if book is available" do
    new_book = Book.create!(title: "Another Book", author: "Author", isbn: "0987654321")
    assert_difference "Borrowing.count", 1 do
      post book_borrowings_path(new_book)
    end
    follow_redirect!
    assert_match /Book borrowed successfully/, response.body
  end

  test "should not create borrowing if book is not available" do
    # @book is already borrowed in setup.
    assert_no_difference "Borrowing.count" do
      post book_borrowings_path(@book)
    end
    follow_redirect!
    assert_match /is already borrowed/, response.body
  end

  test "should return a book" do
    put borrowing_path(@borrowing)
    follow_redirect!
    assert_match /Book returned successfully/, response.body
    @borrowing.reload
    assert_not_nil @borrowing.returned_at
  end
end
