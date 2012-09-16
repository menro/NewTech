class County < ActiveRecord::Base
  has_many :cities

  has_many :offices, :through => :cities

  has_many :companies, :through => :offices

  has_many :tags, :through => :companies

  attr_accessible :name, :zip, :state, :latitude, :longitude

  scope :with_companies_founded_from,
        lambda {|year|
          joins(:companies).merge(Company.founded_from(year))
        }

  scope :with_companies_founded_to,
        lambda {|year|
          joins(:companies).merge(Company.founded_to(year))
        }

  scope :with_company_tagged_as,
        lambda {|tag_code|
          joins(:tags).merge(Company.tagged_as(tag_code))
        }


end
