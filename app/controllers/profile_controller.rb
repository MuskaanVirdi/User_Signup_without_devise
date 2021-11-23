class ProfileController < ApplicationController
  before_action :user_logged_in?

  def edit_profile
    @user = User.find(session[:user])		
      if request.post?
          if @user
            if @user.update(user_params)
                NotificationMailer.edit_profile_confirmation(@user).deliver
                flash[:notice] = "Your profile has been successfully updated.."
                redirect_to :action=>"dashboard",:controller=>"home"
             else
                render :action=>"edit_profile"
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
  


  private
  def user_params
      params.require(:user).permit(:first_name, :last_name, :date_of_birth, :mobile,:profile_image)
  end
end
