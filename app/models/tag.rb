class Tag < ActiveRecord::Base
  has_and_belongs_to_many :companies

  has_many :city, :through => :companies

  scope :with_companies_founded_from,
        lambda {|year|
          joins(:companies).merge(Company.founded_from(year))
        }

  scope :with_companies_founded_to,
        lambda {|year|
          joins(:companies).merge(Company.founded_to(year))
        }

  scope :with_company_are_hiring,
        joins(:companies).merge(Company.are_hiring)

  scope :with_company_employee_type,
        lambda {|employee_id|
          joins(:companies).merge(Company.employee_type(employee_id))
        }

  scope :with_company_investment_type,
        lambda {|investment_id|
          joins(:companies).merge(Company.investment_type(investment_id))
        }

  # TODO rename this with company prefix
  scope :located_in_county,
        lambda {|county_id|
          joins(:city).merge(Company.located_in_county(county_id))
        }

end
