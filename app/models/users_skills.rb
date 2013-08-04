class UsersSkills < ActiveRecord::Base
  belongs_to :user
  belongs_to :skill_type
  # attr_accessible :title, :body
end
