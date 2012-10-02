class User < ActiveRecord::Base
  has_many :companies

  rolify

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :confirmable, :lockable, :timeoutable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me

  validates_uniqueness_of :username, :email

  def is_admin?
    has_role?(:admin)
  end

  def name
    self.username
  end
end
