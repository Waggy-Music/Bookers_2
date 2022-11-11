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
    else
    @user=current_user
    render :edit
    end
  end
  
  def index
    @user=current_user
    @book=Book.new
    @books=Book.all
   # if sort_params.present?
   #    @books = Book.sort_books(sort_params)
   # else
   #    @books  = Book.all
   # end
   #  @sort_list = Book.sort_list
   if params[:latest]
     @books = Book.latest
   elsif params[:old]
     @books = Book.old
   elsif params[:score_count]
     @books = Book.score_count
   elsif params[:favorite]
    #@books=Book.count 
    @books = Book.includes(:favorited_users).sort_by {|x|
     x.favorited_users.size
    }.reverse
   else
    @books = Book.all
   end
    
  end
  
  

  def show
    @book=Book.new
    @books=Book.find(params[:id])
    @user=@books.user
    @book_comment = BookComment.new
  end
  
  def edit
    @book=Book.find(params[:id])
    if current_user!=@book.user
     redirect_to books_path
    end
  end
  
  def destroy
  book=Book.find(params[:id])
  book.destroy
  redirect_to books_path
  flash[:notice]="Book was successfully destroyed."
  end


private

 def book_params
  params.require(:book).permit(:title,:body, :score,:tag)
 end  
 
 # def sort_params
 #      params.permit(:sort)
 # end
end