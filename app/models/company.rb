class Company < ActiveRecord::Base
  attr_accessible :name, :offices_attributes, :email_address, :founded_year, :description,
                  :homepage_url, :twitter, :facebook, :jobs_url

  belongs_to  :user

  belongs_to  :category

  delegate :id, :to => :category, :prefix => true

  has_many :offices, :dependent => :delete_all

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

end
