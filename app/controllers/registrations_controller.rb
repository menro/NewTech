class RegistrationsController < Devise::RegistrationsController


  def create
    @user = UserService::register_new_user params[:user]
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
    else
      render :new
    end
  end

end