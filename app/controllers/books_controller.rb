class BooksController < ApplicationController
  
  def new
  @book=Book.new(book_params)
  end
  
  def create
  @book=Book.new(book_params)
  @book.user_id = current_user.id
   if @book.save
    flash[:notice]="Book was successfully created."
  redirect_to book_path(@book.id)
   else
    flash[:danger]="errors prohibited this book from being saved:"
    @books=Book.all
    @user=current_user
     render:index
   end
  end
  
  
  def update
    @book=Book.find(params[:id])
    @book.update(book_params)
    if @book.save
   flash[:notice]="You have updated book successfully."
    redirect_to book_path(@book.id)
    end
  end
  
  def index
    @user=current_user
    @book=Book.new
    @books=Book.all
  end

  def show
    @user=current_user
    @book=Book.new
    @books=Book.all
  end
  
  def edit
    @book=Book.find(params[:id])
  end
  
  def destroy
  book=Book.find(params[:id])
  book.destroy
  redirect_to books_path
  flash[:notice]="Book was successfully destroyed."
  end


private

 def book_params
  params.require(:book).permit(:title,:body)
 end  
end