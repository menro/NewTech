class Tool < ActiveRecord::Base
  attr_accessible :name

  has_many :tool_sets, class_name: "UsersTools"
  has_many :users, through: :tool_sets
end
