class Borrowing < ApplicationRecord
  belongs_to :user
  belongs_to :book

  # Prevent borrowing a book that is already checked out.
  validate :book_must_be_available, on: :create

  before_create :set_borrowed_at_and_due_date

  def book_must_be_available
    if book && !book.available?
      errors.add(:book, "is already borrowed")
    end
  end

  def set_borrowed_at_and_due_date
    self.borrowed_at = Time.current
    self.due_date    = 2.weeks.from_now
  end

  # Mark the borrowing as returned.
  def return_book!
    update!(returned_at: Time.current)
  end
end
