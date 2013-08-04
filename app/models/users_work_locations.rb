class UsersWorkLocations < ActiveRecord::Base
  belongs_to :user
  belongs_to :work_location_type
  # attr_accessible :title, :body

end
