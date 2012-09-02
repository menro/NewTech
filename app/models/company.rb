class Company < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :category

  has_many :offices, :dependent => :delete_all

  has_and_belongs_to_many :tags

  def in_colorado?
    !offices.find_by_state_code("CO").nil?
  end

end
