class SessionsController < Devise::SessionsController


  def after_sign_in_path_for(rsource)
    session[:return_to] || request.referrer || root_path
  end
end