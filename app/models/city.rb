class City < ActiveRecord::Base
  belongs_to  :county

  has_many :companies
  has_many :jobs

  attr_accessible :county_id, :name, :state, :latitude, :longitude

  validates_presence_of :county_id, :name, :state, :latitude, :longitude

  validates_numericality_of :latitude, :longitude


end
