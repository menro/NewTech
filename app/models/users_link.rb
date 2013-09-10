class UsersLink < ActiveRecord::Base
  belongs_to :user
  attr_accessible :link_url, :name
end
