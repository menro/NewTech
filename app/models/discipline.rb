class Discipline < ActiveRecord::Base
  attr_accessible :name, :platforms_name, :languages_name

  has_many :languages
  has_many :platforms
end
