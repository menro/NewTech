class Company < ActiveRecord::Base
  attr_accessible :name, :offices_attributes, :email_address, :founded_year, :description,
                  :homepage_url, :twitter, :facebook, :jobs_url, :hiring, :image,
                  :investments_type_id, :employees_type_id, :category_id, :presentation_date,
                  :user_id, :enabled, :presented, :address, :city_id, :zip_code, :latitude, :longitude

  belongs_to  :user

  belongs_to  :investments_type

  belongs_to  :employees_type

  belongs_to :city

  belongs_to :county

  belongs_to :category

  has_and_belongs_to_many :tags

  validates_presence_of :address, :city_id, :zip_code, :category_id

  validates_numericality_of :zip_code

  before_save :attach_county

  has_attached_file :image,
                    :styles => {
                        :thumbnail => "160x120>"
                    },
                    :storage => :s3,
                    :s3_protocol => 'https',
                    :s3_permissions => :public_read,
                    :bucket => configatron.s3.bucket,
                    :s3_credentials => {
                        :access_key_id => configatron.s3.credentials.access_key_id,
                        :secret_access_key => configatron.s3.credentials.secret_access_key
                    },
                    :path => "/:class/:id/:style.:extension"


  validates_attachment_size :image, :less_than => 1.megabyte
  validates_attachment_content_type :image, :content_type => /image/

  validates_presence_of :name, :email_address, :founded_year

  validates_numericality_of :founded_year, :less_than_or_equal_to => Time.now.year

  scope :name_like,
        lambda {|name|
          where("companies.name LIKE ?", "%#{name}%")
        }

  scope :founded_from,
        lambda {|year|
          where("companies.founded_year >= ?", year)
        }

  scope :founded_to,
        lambda {|year|
          where("companies.founded_year <= ?", year)
        }


  scope :tagged_as,
        lambda {|tag_code|
          joins(:tags).where("tags.code = ?", tag_code)
        }


  scope :are_hiring, where("companies.hiring = true")

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

  scope :located_in_county,
        lambda {|id|
          where("companies.county_id = ?", id)
        }

  def number_of_employees
    employees_type.name
  end

  def tags_list
    tags.map(&:code).join(", ")
  end


  private
  def attach_county
    self.county = city.county unless city.county.nil?
  end

end
