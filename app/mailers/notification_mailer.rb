class NotificationMailer < ApplicationMailer
    def registration_confirmation(user)
        @user = user
        mail(to: 'samarjotsinghvirdi@gmail.com', subject: 'Congratulation! Your account is created!')
    end

    def welcome_confirmation(user)
        @user = user
        mail(to: 'samarjotsinghvirdi@gmail.com', subject: 'You are logged in..')
    end

    def logout_confirmation
        mail(to: 'samarjotsinghvirdi@gmail.com', subject: 'You are logged out..')
    end
end
