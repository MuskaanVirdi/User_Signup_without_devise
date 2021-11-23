class PasswordController < ApplicationController
  def forget_password
    if request.post?
			@user = User.find_by_email(params[:email])
			if @user
			   new_password = random_password
			   @user.update(:password=>new_password)
			   flash[:notice] = "A new password has been sent your email"
			   NotificationMailer.random_password_send(@user,new_password).deliver
			   redirect_to :action=>"login",:controller=>"account"
			else
			   flash[:alert]="Invalid Email.Please enter correct email"
			   render :action=>"forget_password"
			end
		
		end
  end

  def random_password
    (0...8).map{65.+(rand(25)).chr}.join
  end

  def reset_password
	@user = User.find(session[:user])	
		if request.post?		
		 if @user
	    puts "====================================================== #{params[:password]} #{@user.inspect}"		
         if @user.update(:password=>params[:password]) 
         NotificationMailer.reset_password_confirmation(@user).deliver
         flash[:notice] = "Your password has been reset successfully"
         redirect_to :action=>"dashboard",:controller=>"home"
		  else
				render :action=>"reset_password"
		  end
		end
    end
  end

  def user_logged_in?
	if session[:user].nil?
	  flash[:alert]="First Login to access private route.."
	  redirect_to :controller => "account",:action => "login"
  end
end

def user_params
	params.permit(:password,:hashed_password)
end
end
