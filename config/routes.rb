Rails.application.routes.draw do
  get 'profile/edit_profile'
  post 'profile/edit_profile'
  get 'password/forget_password'
  post 'password/forget_password'
  get 'password/reset_password'
  post 'password/reset_password'
  get 'account/sign_up'
  post 'account/sign_up'
  get 'account/login'
  get 'account/logout'
  post 'account/login'
  get 'home/dashboard'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
