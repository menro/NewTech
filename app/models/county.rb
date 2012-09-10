class County < ActiveRecord::Base
  attr_accessible :name, :zip, :state, :latitude, :longitude
end
