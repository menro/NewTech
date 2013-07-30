class UsersPlatforms < ActiveRecord::Base
  belongs_to :user
  belongs_to :platform
  # attr_accessible :title, :body
end
