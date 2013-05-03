class Job < ActiveRecord::Base

  attr_accessible :city_id,
                  :kind,
                  :role,
                  :salary_high,
                  :salary_low,
                  :equity_high,
                  :equity_low,
                  :hourly_high,
                  :hourly_low,
                  :skill_list,
                  :title,
                  :zip_code,
                  :expires_on,
                  :link,
                  :email,
                  :company_id

  belongs_to :company, counter_cache: true
  belongs_to :city
  has_and_belongs_to_many :skills

  attr_accessor :skill_list

  validates :city_id,
            :company_id,
            :kind,
            :role,
            :title,
            presence: true

  scope :currently_running,
        lambda { where("jobs.created_at > ?", 30.days.ago) }

  scope :title_like,
        lambda {|title|
          where("jobs.title ILIKE ?", "%#{title}%")
        }

  scope :tagged_as,
        lambda {|tag_code|
          joins(:company => :tags).where("tags.code = ?", tag_code)
        }

  scope :with_skill,
        lambda {|skill_name|
          joins(:skills).where("skills.name = ?", skill_name)
        }

  scope :employee_type,
        lambda {|employee_id|
          joins(:company).where("companies.employees_type_id = ?", employee_id)
        }

  scope :investment_type,
        lambda {|investment_id|
          joins(:company).where("companies.investments_type_id = ?", investment_id)
        }

  scope :with_category,
        lambda {|category_id|
          joins(:company).where("companies.category_id = ?", category_id)
        }

  scope :with_kind,
        lambda { |kind| where(kind: kind) }

  scope :with_role,
        lambda { |role| where(role: role) }

  scope :located_in_county,
        lambda {|id|
          joins(:city).where("cities.county_id = ?", id)
        }

  scope :founded_from,
        lambda {|year|
          joins(:company).where("companies.founded_year >= ?", year)
        }

  scope :founded_to,
        lambda {|year|
          joins(:company).where("companies.founded_year <= ?", year)
        }
end
