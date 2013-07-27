class FreelancersTools < ActiveRecord::Base
  belongs_to :freelancer
  belongs_to :tool
  # attr_accessible :title, :body
end
