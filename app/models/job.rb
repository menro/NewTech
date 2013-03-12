class Job < ActiveRecord::Base

  attr_accessible :city_id,
                  :kind,
                  :role,
                  :salary_high,
                  :salary_low,
                  :skills,
                  :title,
                  :zip_code,
                  :expires_on,
                  :link,
                  :email,
                  :company_id

  belongs_to :company
  belongs_to :city

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

  scope :employee_type,
        lambda {|employee_id|
          where("companies.employees_type_id = ?", employee_id)
        }

  scope :investment_type,
        lambda {|investment_id|
          where("companies.investments_type_id = ?", investment_id)
        }

  scope :with_category,
        lambda {|category_id|
          where("companies.category_id = ?", category_id)
        }

end
