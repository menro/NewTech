class County < ActiveRecord::Base
  has_many :cities

  has_many :offices, :through => :cities

  has_many :companies, :through => :offices

  has_many :tags, :through => :companies

  has_many :employees_types, :through => :companies

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

  scope :with_company_are_hiring,
        joins(:companies).merge(Company.are_hiring)

  scope :with_company_employee_type,
        lambda {|employee_id|
          joins(:employees_types).merge(Company.employee_type(employee_id))
        }
end
