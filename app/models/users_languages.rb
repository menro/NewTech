class UsersLanguages < ActiveRecord::Base
  belongs_to :user
  belongs_to :language
  # attr_accessible :title, :body
end
