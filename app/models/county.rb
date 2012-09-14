class County < ActiveRecord::Base
  has_many :cities

  has_many :offices, :through => :cities

  attr_accessible :name, :zip, :state, :latitude, :longitude


  scope :with_companies_founded_from_year,
        lambda {|year|
          joins(:offices).merge(Office.with_companies_founded_from_year(year))
        }

  scope :with_companies_founded_to_year,
        lambda {|year|
          joins(:offices).merge(Office.with_companies_founded_to_year(year))
        }


end
