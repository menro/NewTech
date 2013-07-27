class FreelancersPlatforms < ActiveRecord::Base
  belongs_to :freelancer
  belongs_to :platform
  # attr_accessible :title, :body
end
