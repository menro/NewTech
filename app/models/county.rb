class County < ActiveRecord::Base
  has_many :cities

  has_many :offices, :through => :cities

  has_many :companies, :through => :offices

  attr_accessible :name, :zip, :state, :latitude, :longitude


  scope :with_companies_founded_from,
        lambda {|year|
          joins(:companies).where("`companies`.founded_year > ?", year)
        }

  scope :with_companies_founded_to,
        lambda {|year|
          joins(:companies).where("`companies`.founded_year < ?", year)
        }


end
