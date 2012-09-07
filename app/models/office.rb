class Office < ActiveRecord::Base
  attr_accessible :address1, :city, :zip_code

  belongs_to :company

  delegate :name, :category_id, :permalink, :homepage_url, :description, :overview,
           :number_of_employees, :founded_year, :email_address, :phone_number,
           :to => :company, :prefix => true

  validates_presence_of :address1, :city, :zip_code
end
