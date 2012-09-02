class Company < ActiveRecord::Base
  belongs_to :user

  has_many :offices
  accepts_nested_attributes_for :offices

  has_and_belongs_to_many :tags

  def in_colorado?
    !offices.find_by_state_code("CO").nil?
  end

end
