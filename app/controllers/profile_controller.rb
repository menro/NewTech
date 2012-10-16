class ProfileController < ApplicationController
  before_filter :authenticate_user!
  before_filter :user

  def show
  end

  def update
    @user.update_attributes(params[:user])
    flash[:notice] = "Profile was successfully updated."
    redirect_to :back
  end

  def password_update
    params[:user].reject!{ |k, v| k != "password" && k != "password_confirmation"}

    if @user.update_attributes(params[:user])
      flash[:notice] = "Password was successfully updated. Please login with it"
      redirect_to new_user_session_path
    else
      flash.now[:error] = "We're sorry, but something went wrong. Try again"
      render action: "show"
    end
  end

  private

  def user
    @user = current_user
  end

end
