class UsersController < ApplicationController

before_action :authenticate_user! #ログイン済ユーザーのみにアクセスを許可するヘルパー　境界線
before_action :correct_user, only: [:edit, :update]

def index
  @books = Book.all
  @book = Book.new
  @user = current_user
  @users = User.all
end

def edit
  @user = User.find(params[:id])
end

def show
  @user = User.find(params[:id])
  @books = @user.books    #bookとuserの紐づけ
  @book = Book.new  #ここでパラムスを使うとuserのIDが入ってしまう
end

def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    redirect_to user_path(@user.id), notice:'successfully'
    else
      flash[:danger] = @user.errors.full_messages
      render :new
    end
end

 def create
  	@book = Book.new(book_params)
    @book.user_id = current_user.id　#現在ログインしているユーザーをとっている
    if @book.save
      redirect_to books_path, notice:'successfully'
    else
      flash[:danger] = @user.errors.full_messages
      #flash.now[:alert] = 'error'
      #redirect_to user_path
      render :new
    end
  end


   def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def correct_user
    user = User.find(params[:id])
    redirect_to user_path(current_user) if current_user != user
  end

end




