class Recommendation < ActiveRecord::Base
  belongs_to :user
  belongs_to :skill_type
  belongs_to :user, class_name: "User", foreign_key: "recommendi_id"
  attr_accessible :recommendi_id

  def recommendi
    User.find(recommendi_id)
  end
end
