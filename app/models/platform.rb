class Platform < ActiveRecord::Base
  attr_accessible :name, :on_page

  has_many :platform_sets, class_name: "UsersPlatforms"
  has_many :users, through: :platform_sets

  has_many :endorsements, as: :skillable, class_name: 'Recommendation'
  
  scope :on_page, where(on_page: true)
  scope :on_popup, where(on_page: false)

  def user_endorsements(recommendi_id)
    endorsements.where(recommendi_id: recommendi_id)
  end
end
