module UsersHelper
  def viewing_own_profile?
    user = User.where(username: params[:username]).first
    if current_user.nil?
      return false
    elsif user && current_user.id = user.id
      return true
    end
    false
  end
end
