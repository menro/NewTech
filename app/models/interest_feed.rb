class InterestFeed < ActiveRecord::Base
  belongs_to :user
  belongs_to :followable, polymorphic: true
  attr_accessible :followable
end
