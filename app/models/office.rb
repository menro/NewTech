class Office < ActiveRecord::Base
  belongs_to :company

  delegate :name, :permalink, :homepage_url, :blog_url, :description, :overview,
           :number_of_employees, :founded_year, :email_address, :phone_number,
           :to => :company, :prefix => true
end
