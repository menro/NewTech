class Category < ActiveRecord::Base
  attr_accessible :id, :name, :marker_image, :description, :marker_icon

  has_many :companies

  has_many :tags, :through => :companies

  default_scope order('categories.name ASC')

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
  scope :with_companies_in_zipcode,
        lambda {|zipcode_id|
          joins(:companies).merge(Company.located_in_county_zipcode(zipcode_id))
        }

  scope :with_company_are_hiring,
        joins(:companies).merge(Company.are_hiring)

  scope :with_company_raising_money,
        joins(:companies).merge(Company.are_raising_money)

  scope :with_company_employee_type,
        lambda {|employee_id|
          joins(:companies).merge(Company.employee_type(employee_id))
        }

  scope :with_company_investment_type,
          lambda {|investment_id|
            joins(:companies).merge(Company.investment_type(investment_id))
          }

  scope :group_name_with_companies,
          lambda {|filter|
            joins(:companies).merge(filter)
            .select("categories.name as category_name, count(companies.id) as companies_count")
            .group("categories.name")
          }

  has_attached_file :marker_icon,
                    :styles => {
                        thumb: "100x100>",
                        icon: "25x25>",
                        regular: "175x175>",
                        small: "35x35>"
                    },
                    :default_url => "http://b.dryicons.com/images/icon_sets/colorful_stickers_icons_set/png/256x256/help.png",
                    :storage => :s3,
                    :s3_protocol => 'https',
                    :s3_permissions => :public_read,
                    :bucket => configatron.s3.bucket,
                    :s3_credentials => {
                        :access_key_id => configatron.s3.credentials.access_key_id,
                        :secret_access_key => configatron.s3.credentials.secret_access_key
                    },
                    :path => "/:class/:id/:style.:extension"


end
