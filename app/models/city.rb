class City < ActiveRecord::Base
  belongs_to  :county
end
