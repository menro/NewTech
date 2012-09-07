class Company < ActiveRecord::Base
  belongs_to  :user

  belongs_to  :category

  delegate :id, :to => :category, :prefix => true

  has_many :offices, :dependent => :delete_all

  has_and_belongs_to_many :tags

  validates_presence_of :name

  def out_of_colorado?
    offices.find_by_state_code("CO").nil?
  end

end
