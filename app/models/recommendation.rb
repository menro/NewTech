class Recommendation < ActiveRecord::Base

  # in this model, recommendi_id is the user who actually being recommended/endorsed
  # user_id, is the user who recommends/endorsed the other user.

  belongs_to :user, class_name: "User", foreign_key: "recommendi_id"
  attr_accessible :recommendi_id, :skillable_id, :skillable_type

  belongs_to :skillable, polymorphic: true
  after_create :send_email

  def recommender
    # who gets recommended
    user
  end

  def recommendi
    #who recommends someone
    User.find(user_id)
  end

  def send_email
    AppMailer.endorsement(recommender, recommendi, skillable).deliver if recommender.receive_notification?
  end

end
