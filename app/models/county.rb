class County < ActiveRecord::Base
  has_many :cities

  has_many :offices, :through => :cities

  attr_accessible :name, :zip, :state, :latitude, :longitude
end
