class UserService

  def self.register_new_user( user )
    return User.new do |u|
      u.username = user['username']
      u.email = user['email']
      u.password = user['password']
      u.password_confirmation = user['password_confirmation']
      u.is_freelancer = user[:is_freelancer]
    end
  end

  def self.update_user(user, attributes = {})
    user.update_attributes attributes
  end

  def self.search(attributes = {})
    # User.where(county_id: attributes[:current_county_id]).limit(7)
    User.available_freelancers(7)
  end

end
