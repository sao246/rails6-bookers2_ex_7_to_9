class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @book_comment = current_user.book_comments.new(book_comment_params)
    @book_comment.book_id = @book.id
  
    if @book_comment.save
      respond_to do |format|
        format.js  # create.js.erb を呼び出す
      end
    else
      respond_to do |format|
        format.js { render js: "alert('コメントの投稿に失敗しました');" }
      end
    end
  end
  

  def destroy
    @book_comment = BookComment.find(params[:id])
    @book = @book_comment.book
    @book_comment.destroy
  
    respond_to do |format|
      format.js  # destroy.js.erb を呼び出す
    end
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

  def is_matching_login_comment
    book_comment = BookComment.find(params[:id])
    unless book_comment.user.id == current_user.id
      redirect_to books_path
    end
  end
end
