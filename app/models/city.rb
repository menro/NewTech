class City < ActiveRecord::Base
  belongs_to  :county

  has_many :companies

end
