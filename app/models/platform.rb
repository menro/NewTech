class Platform < ActiveRecord::Base
  attr_accessible :name, :on_page

  has_many :platform_sets, class_name: "UsersPlatforms"
  has_many :users, through: :platform_sets


  
end
