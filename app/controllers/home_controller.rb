class HomeController < ApplicationController
    

  def dashboard
    @user = User.find(session[:user])
  end


  def user_logged_in?
    if session[:user].nil?
      flash[:alert]="First Login to access private route.."
      redirect_to :controller => "account",:action => "login"
    end
  end
 
end
