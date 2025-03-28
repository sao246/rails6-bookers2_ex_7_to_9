class BooksController < ApplicationController
  before_action :is_matching_login_book, only: [:edit, :update]
  def new
    @book = Book.new
  end 

  def show
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
    @user = User.find(params[:id])

    unless ViewCount.find_by(user_id: current_user.id, book_id: @book.id)
      current_user.view_counts.create(book_id: @book.id)
    end
    @user = @book.user
    @new_book = Book.new
    @book_comment = BookComment.new
  end

  def index
    book = Book.new
    @book = Book.new
    books = Book.by_weekly_favorites_count
    @books = Book.by_weekly_favorites_count
  end

  def create
    book = Book.new
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def is_matching_login_book
    book = Book.find(params[:id])
    unless book.user.id == current_user.id
      redirect_to books_path
    end
  end
end
