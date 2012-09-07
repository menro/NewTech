class UserService

  def self.register_new_user( user )
    return User.create do |u|
      u.username = user['username']
      u.email = user['email']
      u.password = user['password']
      u.password_confirmation = user['password_confirmation']
    end
  end
end
