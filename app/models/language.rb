class Language < ActiveRecord::Base
  attr_accessible :name, :on_page

  has_many :language_sets, class_name: "UsersLanguages"
  has_many :users, through: :language_sets

  has_many :endorsements, as: :skillable, class_name: 'Recommendation'
  belongs_to :discipline
  
  scope :on_page, where(on_page: true)
  scope :on_popup, where(on_page: false)

  def user_endorsements(recommendi_id)
    endorsements.where(recommendi_id: recommendi_id)
  end

  def endorsed_by_current_user?(user)
    rec = current_user.recommendies.where("skillable_id=? and user_id=? and skillable_type=?", self.id, user.id, self.class.name)
    rec.present?
  end
end
