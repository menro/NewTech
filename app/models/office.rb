class Office < ActiveRecord::Base
  belongs_to :company

  delegate :name, :category_id, :permalink, :homepage_url, :description, :overview,
           :number_of_employees, :founded_year, :email_address, :phone_number,
           :to => :company, :prefix => true
end
