class Event < ActiveRecord::Base
  attr_accessible :title, :preview, :start_at
end
