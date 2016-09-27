class SessionsController < ApplicationController
  def login_params
    params.require(:user).permit(:user_id, :email, :session_token)
  end
  
  def new
       
  end
   
  def create
    user_with_id = User.find_by_user_id(login_params[:user_id])
    if user_with_id != nil && user_with_id.email == login_params[:email]
      session[:session_token] = user_with_id.session_token
      redirect_to movies_path
    else
      flash[:warning] = " Invalid user-id/e-mail combination"
      redirect_to login_path
    end
  end
  
  def destroy
    session[:session_token] = nil;
    @current_user = nil;
    redirect_to movies_path
  end
end