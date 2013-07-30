class JobType < ActiveRecord::Base
  attr_accessible :name

  has_one :user

end
