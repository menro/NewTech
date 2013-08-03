class Language < ActiveRecord::Base
  attr_accessible :name

  has_many :language_sets, class_name: "UsersLanguages"
  has_many :users, through: :language_sets

end
