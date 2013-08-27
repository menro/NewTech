class Discipline < ActiveRecord::Base
  attr_accessible :name

  has_many :languages
  has_many :platforms
end
