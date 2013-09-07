module UsersHelper
  def viewing_own_profile?
    user = User.where(username: params[:username]).first
    if current_user.nil?
      return false
    elsif user && current_user.id == user.id
      return true
    end
    false
  end

  def thumbnail_url(user, size)
    user.is_freelancer? ? user.avatar.url(size) : (user.companies.present? ? user.companies.first.image.url(size) : user.avatar.url(size))
  end

  def user_profile_url(user)
    user.is_freelancer? ? show_freelancer_users_path(user.username) : profile_path
  end
end
