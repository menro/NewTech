class Zipcode < ActiveRecord::Base
  attr_accessible :code, :latitude, :longitude

  has_and_belongs_to_many :counties
end
