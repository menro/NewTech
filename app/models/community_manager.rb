class CommunityManager < ActiveRecord::Base
  belongs_to :user
  belongs_to :county
  belongs_to :discipline

  attr_accessible :user_id, :county_id, :discipline_id, :mission

  def pic_url(size = :thumb)
    user.avatar.url(size)
  end

  def name
    user.username
  end

end
