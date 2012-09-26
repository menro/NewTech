class User < ActiveRecord::Base
  has_many :companies

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :confirmable, :lockable, :timeoutable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me


  # TODO: implement real roles logic
  def is_admin?
    return username.eql?("admin")
  end
end
