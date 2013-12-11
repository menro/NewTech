class CommunityManager < ActiveRecord::Base
  belongs_to :user
  belongs_to :county

  attr_accessible :user_id, :county_id
end
