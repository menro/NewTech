class FreelancersLanguages < ActiveRecord::Base
  belongs_to :freelancer
  belongs_to :language
  # attr_accessible :title, :body
end
