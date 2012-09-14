class Office < ActiveRecord::Base
  attr_accessible :address1, :city_id, :zip_code, :latitude, :longitude

  belongs_to :company

  belongs_to :city

  delegate :name, :category_id, :permalink, :homepage_url, :description, :overview,
           :number_of_employees, :founded_year, :email_address, :phone_number,
           :to => :company, :prefix => true

  validates_presence_of :address1, :city_id, :zip_code

  validates_numericality_of :zip_code

  scope :with_companies_founded_from_year,
        lambda {|year|
          where("`offices`.company_id IN ( SELECT id FROM companies where founded_year > ? )", year)
        }

  scope :with_companies_founded_to_year,
        lambda {|year|
          where("`offices`.company_id IN ( SELECT id FROM companies where founded_year < ? )", year)
        }
end
