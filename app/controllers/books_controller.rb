class BooksController < ApplicationController

  before_action :authenticate_user!, except: [:top, :about]
  before_action :correct_user, only: [:edit, :update, :destroy]#どっかのアクションを通る前に

  def create
    #@books = Book.all
  	@book = Book.new(book_params)
    @user = current_user
    @book.user_id = current_user.id #bookとuserを結んでる
    if @book.save
      redirect_to book_path(@book.id), notice:'successfully'
    else
      flash[:danger] = @book.errors.full_messages
      @books = Book.all
      render action: :index
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    redirect_to book_path(@book.id), notice:'successfully'
    else
      flash[:danger] = @book.errors.full_messages
      render action: :edit
    end
  end


  def edit
    @book = Book.find(params[:id])
    #@user = current_user
  end

  def about
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def show
    #@user = User.find(params[:id])
    @book = Book.find(params[:id])#なにかのID
    @user = User.find(@book.user_id)#@bookは上のbook
  end

  def top
  end


  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end



   private
  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end

  def correct_user
    book = Book.find(params[:id])
    user = book.user
    redirect_to books_path if current_user != user
  end

end
