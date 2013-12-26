class State < ActiveRecord::Base
  attr_accessible :country, :latitude, :longitude, :name

  validates_presence_of :name
  
  has_many :events

  has_many :counties
  
end
