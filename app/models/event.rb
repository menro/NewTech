class Event < ActiveRecord::Base
  attr_accessible :title, :preview, :start_at, :county_id, :state_id

  belongs_to :county
  belongs_to :state

end
