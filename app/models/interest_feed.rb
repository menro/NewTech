class InterestFeed < ActiveRecord::Base
  belongs_to :user
  attr_accessible :followable, polymorphic: true
end
