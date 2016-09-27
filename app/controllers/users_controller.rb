class UsersController < ApplicationController

  def user_params
    params.require(:user).permit(:user_id, :email, :session_token)
  end

  def show
    id = params[:user_id] # retrieve user ID from URI route
    @user = User.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @users = User.all
  end

  def edit
    @user = User.find params[:user_id]
  end

  def update
    @user = User.find params[:user_id]
    @user.update_attributes!(user_params)
    flash[:notice] = "#{@user.user_id} was successfully updated."
    redirect_to users_path(@user)
  end

  def destroy
    @user = User.find(params[:user_id])
    @user.destroy
    flash[:notice] = "User '#{@user.user_id}' deleted."
    redirect_to users_path
  end
  
  def new
       
  end
   
  def create
    user_with_id = User.find_by_user_id(user_params[:user_id])
    if user_with_id != nil
      flash[:warning] = "Sorry, this user-id is taken. Try again."
      redirect_to new_user_path
    else
      @user = User.create_user!(user_params)
      flash[:notice] = " Welcome #{@user.user_id}. Your account has been created."
      redirect_to login_path
    end
  end
end