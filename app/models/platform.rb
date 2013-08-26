class Platform < ActiveRecord::Base
  attr_accessible :name, :on_page

  has_many :platform_sets, class_name: "UsersPlatforms"
  has_many :users, through: :platform_sets

  has_many :endorsements, as: :skillable, class_name: 'Recommendation'
  
  def user_endorsements(recommendi_id)
    endorsements.where(recommendi_id: recommendi_id)
  end
end
