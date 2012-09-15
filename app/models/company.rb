class Company < ActiveRecord::Base
  attr_accessible :name, :offices_attributes, :email_address, :founded_year, :description,
                  :homepage_url, :twitter, :facebook, :jobs_url, :hiring, :image, :number_of_employees, :investment

  belongs_to  :user

  has_many :offices, :dependent => :destroy

  accepts_nested_attributes_for :offices

  has_and_belongs_to_many :tags

  has_attached_file :image,
                    :styles => {
                        :medium => "256x256#"
                    },
                    :url  => ':class/:id/image/:style',
                    :path => ':rails_root/uploads/:class/:id_partition/:style.:extension'


  validates_presence_of :name, :email_address, :founded_year

  validates_numericality_of :founded_year, :less_than => Time.now.year

  scope :founded_from,
        lambda {|year|
          where("founded_year > ?", year)
        }

  scope :founded_to,
        lambda {|year|
          where("founded_year < ?", year)
        }

end
