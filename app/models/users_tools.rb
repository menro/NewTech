class UsersTools < ActiveRecord::Base
  belongs_to :user
  belongs_to :tool
  # attr_accessible :title, :body
end
