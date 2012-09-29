class Role < ActiveRecord::Base
  TYPES = [:admin, :user]

  has_and_belongs_to_many :users, :join_table => :users_roles
  belongs_to :resource, :polymorphic => true

  attr_accessible :name

  def self.user
    self.find_by_name(:user)
  end

  def self.admin
    self.find_by_name(:admin)
  end
end
