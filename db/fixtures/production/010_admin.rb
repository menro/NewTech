unless User.count > 0
  admin = User.create do |admin|
    admin.username = "admin"
    admin.email = "admin@local.host"
    admin.password = "password1"
    admin.password_confirmation = "password1"
    admin.roles << Role.all
    admin.confirm!
  end

  if admin.valid?
    puts %q[
    Administrator account created:

    login.........admin@local.host
    password......password1
    ]
  end



end
