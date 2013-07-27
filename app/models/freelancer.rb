class Freelancer < ActiveRecord::Base
  attr_accessible :bio, :email, :experience, :github, :gravatar, :jobTitle, :name, :personal_url, :status

  has_many :tool_sets, class_name: "FreelancersTools"
  has_many :tools, through: :tool_sets

  has_many :language_sets, class_name: "FreelancersLanguages"
  has_many :languages, through: :language_sets

  has_many :platform_sets, class_name: "FreelancersPlatforms"
  has_many :platforms, through: :platform_sets
  
end
