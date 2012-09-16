class City < ActiveRecord::Base
  belongs_to  :county

  has_many :offices

  scope :with_county_named,
        lambda {|county_name|
          joins(:county).merge(County.named(county_name))
        }

  scope :with_county_id,
        lambda {|id|
          where("county_id = ?", id)
        }

end
