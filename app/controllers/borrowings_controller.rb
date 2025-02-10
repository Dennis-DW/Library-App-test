# app/controllers/borrowings_controller.rb
class BorrowingsController < ApplicationController
    before_action :require_login
  
    # POST /books/:book_id/borrowings
    def create
      @book = Book.find(params[:book_id])
      @borrowing = current_user.borrowings.new(book: @book)
      if @borrowing.save
        redirect_to book_path(@book),
                    notice: "Book borrowed successfully. Due on #{@borrowing.due_date.strftime("%Y-%m-%d")}."
      else
        redirect_to book_path(@book),
                    alert: @borrowing.errors.full_messages.to_sentence
      end
    end
  
    # PUT /borrowings/:id (to return a book)
    def update
      @borrowing = current_user.borrowings.find(params[:id])
      if @borrowing.return_book!
        redirect_to user_path(current_user), notice: "Book returned successfully."
      else
        redirect_to user_path(current_user), alert: "Error returning book."
      end
    end
  end
  