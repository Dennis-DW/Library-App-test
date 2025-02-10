# FILE: app/controllers/users_controller.rb
class UsersController < ApplicationController
    before_action :require_login, only: [:show]
    before_action :set_user, only: [:show]
  
    def new
      @user = User.new
    end
  
    def create
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        redirect_to books_path, notice: "Account created successfully."
      else
        render :new
      end
    end
  
    def show
      # Profile page: list active borrowings (i.e. not yet returned)
      @borrowings = @user.borrowings.where(returned_at: nil).includes(:book)
    end
  
    private
  
    def set_user
      @user = current_user
      redirect_to root_path, alert: "Not authorized" unless @user
    end
  
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
  end