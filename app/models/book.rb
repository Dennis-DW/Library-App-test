class Book < ApplicationRecord
    has_many :borrowings, dependent: :destroy
    has_many :users, through: :borrowings
  
    validates :title,  :author, :isbn, presence: true
    validates :isbn, uniqueness: true
  
    # A book is available if no active borrowing exists.
    def available?
      borrowings.where(returned_at: nil).empty?
    end
  end
  