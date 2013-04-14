class RegistrationsController < Devise::RegistrationsController

  

  def create
    @user = UserService::register_new_user params[:user]
    if @user.save
      redirect_to email_confirmation_path, :event => :authentication
      #sign_in_and_redirect @user, :event => :authentication
    else
      render '/devise/sessions/new'
    end
  end


end