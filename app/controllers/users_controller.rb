class UsersController < ApplicationController
before_action :authenticate_user! #ログイン済ユーザーのみにアクセスを許可するヘルパー　境界線

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
  @book = Book.new
end

def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    redirect_to user_path(@user.id), notice:'successfully'
    else
      render :new
    end
end



 def create
  	@book = Book.new(book_params)
    @book.user_id = current_user.id　#現在ログインしているユーザーをとっている
    if @book.save
      redirect_to books_path, notice:'successfully'
    else
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
    book = Book.find(params[:id])#本のデータをとってくる
    user = book.user#上記の本を投稿したユーザー
    redirect_to user_path if current_user != user
  end

end




