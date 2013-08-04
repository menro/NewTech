class SessionsController < Devise::SessionsController


  def after_sign_in_path_for(rsource)
    session[:return_to] || root_url
  end

  def after_sign_out_path_for(resource)
    session[:return_to] || root_url
  end
end