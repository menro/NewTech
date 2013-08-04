class User < ActiveRecord::Base

  has_many :companies
  has_many :jobs, through: :companies

  rolify

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :confirmable, :lockable, :timeoutable
  
  ALLOWED_EXP_YEARS = 0..50
  ONSITE_REMOTE = ['remote', 'onsite']
  WORK_STATUS = ['available', 'shortly', 'working']
  USER_RATES = ['$', '$$', '$$$', '$$$$']

  ALLOWED_TOOLS_AS_OPTIONS = Tool.all.map {|t| [t.name.titleize, t.id]}
  ALLOWED_LANGUAGES_AS_OPTIONS = Language.all.map {|t| [t.name.titleize, t.id]}
  ALLOWED_PLATFORMS_AS_OPTIONS = Platform.all.map {|t| [t.name.titleize, t.id]}
  ALLOWED_WORK_STATUS_AS_OPTIONS = WORK_STATUS.map {|t| [t.titleize, t]}
  ALLOWED_JOB_TITLE_AS_OPTIONS = JobType.all.map {|t| [t.name, t.id]}
  ALLOWED_WORK_ONSITE_AS_OPTIONS = WorkLocationType.all.map { |t| [t.name.titleize, t.id]}
  ALLOWED_USER_RATES_AS_OPTIONS = USER_RATES.map { |t| [t, t]}
  ALLOWED_SKILL_TYPES_AS_OPTIONS = SkillType.all.map {|t| [t.name.titleize, t.id]}

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me , :role_ids
  attr_accessible :rate, :github, :personal_url, :full_name, :status, :job_type_id, :experience, :platform_ids, :language_ids, :tool_ids, :address, :town, :zip, :remote_onsite, :outside_colorado, :recommendation_ids, :work_location_ids

  has_many :tool_sets, class_name: "UsersTools"
  has_many :tools, through: :tool_sets

  has_many :language_sets, class_name: "UsersLanguages"
  has_many :languages, through: :language_sets

  has_many :platform_sets, class_name: "UsersPlatforms"
  has_many :platforms, through: :platform_sets

  has_many :work_location_types, class_name: "UsersWorkLocations"
  has_many :work_locations, through: :work_location_types, source: :work_location_type

  has_many :recommendations
  has_many :recommendies, class_name: "Recommendation", foreign_key: "recommendi_id"

  has_many :skills_set, class_name: "UsersSkills"
  has_many :user_skills, through: :skills_set, source: 'skill_type'

  belongs_to :job_type
  validates :username, presence: true, :allow_nil => false, :uniqueness => {:case_sensitive => false}
  validates :email, presence: true, :uniqueness => {:case_sensitive => false}, :allow_nil => false
  validates :experience, numericality: true, :allow_nil => true, inclusion: ALLOWED_EXP_YEARS

  before_save :set_status, :set_username, :set_gravata

  accepts_nested_attributes_for :recommendations

  def is_admin?
    has_role?(:admin)
  end

  def name
    self.full_name || self.username
  end

  def job_title
    job_type.try(:name) || ""
  end

  private
  
  def set_status
    self.status = self.status || 'available'
  end

  def set_username
    self.username = self.username.downcase.gsub(/\s/,'')
  end

  def set_gravata
    self.gravatar = "http://1.gravatar.com/avatar/#{Digest::MD5.hexdigest(self.email)}"
  end
end
