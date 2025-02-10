require "test_helper"

class BorrowingTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(username: "testuser", email: "test@example.com", password: "password", password_confirmation: "password")
    @book = Book.create!(title: "Example Book", author: "Author Name", isbn: "1234567890")
    @borrowing = Borrowing.new(user: @user, book: @book)
  end

  test "should be valid" do
    assert @borrowing.valid?
  end

  test "due date is set to 2 weeks from now" do
    @borrowing.save!
    expected_due_date = 2.weeks.from_now.to_date
    assert_equal expected_due_date, @borrowing.due_date.to_date
  end

  test "should not allow borrowing an already borrowed book" do
    @borrowing.save!
    another_borrowing = Borrowing.new(user: @user, book: @book)
    assert_not another_borrowing.valid?
    assert_includes another_borrowing.errors[:book], "is already borrowed"
  end

  test "return_book! sets returned_at" do
    @borrowing.save!
    assert_nil @borrowing.returned_at
    @borrowing.return_book!
    assert_not_nil @borrowing.returned_at
  end
end
