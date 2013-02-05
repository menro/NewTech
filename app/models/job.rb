class Job < ActiveRecord::Base
  attr_accessible :address, :city_id, :kind, :role, :salary_high, :salary_low, :skills, :title, :zip_code, :latitude, :longitude

  belongs_to :company
  belongs_to :city
end
