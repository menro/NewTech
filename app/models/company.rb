class Company < ActiveRecord::Base
  attr_accessible :name, :offices_attributes, :email_address, :founded_year, :description

  belongs_to  :user

  belongs_to  :category

  delegate :id, :to => :category, :prefix => true

  has_many :offices, :dependent => :delete_all

  accepts_nested_attributes_for :offices

  has_and_belongs_to_many :tags

  validates_presence_of :name, :email_address, :founded_year

  validates_numericality_of :founded_year, :less_than => Time.now.year

  def out_of_colorado?
    offices.find_by_state_code("CO").nil?
  end

end
