class Category < ActiveRecord::Base
  attr_accessible :id, :name, :marker_image, :description

  has_many :companies

  has_many :tags, :through => :companies

  scope :with_companies_name_like,
        lambda {|name|
          joins(:companies).merge(Company.name_like(name))
        }

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
          joins(:companies).merge(Company.tagged_as(tag_code))
        }

  scope :with_companies_in_county,
        lambda {|county_id|
          joins(:companies).merge(Company.located_in_county(county_id))
        }

  scope :with_company_are_hiring,
        joins(:companies).merge(Company.are_hiring)

  scope :with_company_investment_type,
        lambda {|investment_id|
          joins(:companies).merge(Company.investment_type(investment_id))
        }

end
