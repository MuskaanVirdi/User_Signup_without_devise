class AccountController < ApplicationController
  def sign_up
    @user = User.new
  if request.post?
      @new_user = User.new(user_params)
      if @new_user.save
          NotificationMailer.registration_confirmation(@new_user).deliver
          flash[:notice] = "Account is created. Check your email"
          redirect_to :action=>:login
      else
          render :action=>:sign_up 
      end
  end
end

def login
   if request.post?
       @user = User.authenticate(params[:email],params[:password])
         if @user
           #initiate the session if user is authenticated(means email and password are same in database)
           session[:user] = @user.id
           NotificationMailer.welcome_confirmation(@user).deliver
           flash[:notice] = "You are logged in.."
           redirect_to :controller=>:home,:action=>:dashboard
         else
           flash[:alert] = "Invalid Username/Password"
           render :action=>:login
         end
    end
end

def logout
    session[:user] = nil
    NotificationMailer.logout_confirmation.deliver
    flash[:notice] = "You have successfully logged out.."
    redirect_to :action=>:login
end


private
def user_params
    params.require(:user).permit(:first_name, :last_name, :date_of_birth, :mobile, :email ,:password, :hashed_password)
end
end
