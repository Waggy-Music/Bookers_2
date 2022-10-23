class UsersController < ApplicationController
  
    #has_one_attached :image
    
  
  def new
  
  end

  def index
    @user=User.all
    @users=current_user
    @book=Book.new
  end
  
  def create
 
  end
  
  def update
  user_id = params[:id].to_i
  login_user_id = current_user.id
  if(user_id!= login_user_id)
    redirect_to user_path
  end  
    @user=User.find(params[:id]) #配列
   if @user.update(user_params)
     flash[:notice]="You have updated user successfully."
    redirect_to user_path(@user.id) #idひとつだけ持っていく
   else
    render:edit
   end
  end
  
  def show
    @user=User.find(params[:id])
    @book=Book.new
    @books=@user.books
  
  end

  def edit
  user_id = params[:id].to_i
  login_user_id = current_user.id
  if(user_id != login_user_id)
    redirect_to user_path
  end
    @user=User.find(params[:id])
  
  end
  

 private
 
 def user_params
   params.require(:user).permit(:name,:profile_image,:introduction)
 end


end
