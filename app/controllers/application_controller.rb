require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html, :json

  protect_from_forgery

#  before_filter :miniprofiler

  rescue_from CanCan::AccessDenied do |exception|
    sign_out :user if user_signed_in?
    redirect_to new_user_session_path, alert: exception.message

  end

  def authenticate_admin_user
    unless current_user && current_user.is_admin?
      raise CanCan::AccessDenied , "AccessDenied"
    end
  end

  def ensure_county_presence
    if current_user
      unless current_user.has_county_info?
        redirect_to update_county_path
      end
    end
  end

  private

  def miniprofiler
    Rack::MiniProfiler.authorize_request  if current_user && current_user.is_admin?
  end

end
