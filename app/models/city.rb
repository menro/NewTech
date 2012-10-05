class City < ActiveRecord::Base
  belongs_to  :county

  has_many :companies

  scope :with_county_id,
        lambda {|id|
          where("county_id = ?", id)
        }

end
