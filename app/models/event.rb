class Event < ActiveRecord::Base
  attr_accessible :title, :preview, :start_at, :county_id

  belongs_to :county
end
