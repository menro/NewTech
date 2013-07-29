class SkillsEndorsement < ActiveRecord::Base
  belongs_to :user
  belongs_to :job_type
  attr_accessible :rate, :ratings
end
