class Recommendation < ActiveRecord::Base

  # in this model, recommendi_id is the user who actually being recommended/endorsed
  # user_id, is the user who recommends/endorsed the other user.

  belongs_to :user
  belongs_to :skill_type
  belongs_to :user, class_name: "User", foreign_key: "recommendi_id"
  attr_accessible :recommendi_id

  # scope :recommendies, ->{ select('DISTINCT recommendi_id') }
  def recommendi
    User.find(user_id)
  end
end
