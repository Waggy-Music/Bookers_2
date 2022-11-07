class BookCommentsController < ApplicationController
  def create
    @books = Book.find(params[:book_id])
    @comment = current_user.book_comments.new(book_comment_params)
    @comment.book_id = @books.id
    @comment.save
    @comment=BookComment.all
    @user=current_user
  end
    
  #クリエイト、パチっと画面が変わる、削除うまく動かない
  
  def destroy
    @books = Book.find(params[:book_id])
    @comment=BookComment.find_by(id: params[:id], book_id: params[:book_id])
    @comment.destroy
    @user=current_user
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
