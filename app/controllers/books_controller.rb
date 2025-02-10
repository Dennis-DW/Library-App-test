class BooksController < ApplicationController
  before_action :require_login

  def index
    @books = Book.all.includes(:borrowings)
  end

  def show
    @book = Book.find(params[:id])
    @active_borrowing = @book.borrowings.find_by(returned_at: nil)
  end
end