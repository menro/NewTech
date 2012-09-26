class ApplicationController < ActionController::Base
  protect_from_forgery

  def authenticate_admin_user
    unless current_user && current_user.is_admin?
      sign_out :user if user_signed_in?
      redirect_to new_user_session_path, alert: "AccessDenied"
    end
  end

end
