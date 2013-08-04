class WorkLocationType < ActiveRecord::Base
  attr_accessible :name
  
  has_many :work_location_types, class_name: "UsersWorkLocations"
  has_many :users, through: :work_location_types
end
