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
  ALLOWED_WORK_ONSITE_AS_OPTIONS = ONSITE_REMOTE.map { |t| [t.titleize, t]}
  ALLOWED_USER_RATES_AS_OPTIONS = USER_RATES.map { |t| [t, t]}

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me , :role_ids
  attr_accessible :rate, :github, :personal_url, :full_name, :status, :job_type_id, :experience, :platform_ids, :language_ids, :tool_ids, :address, :town, :zip, :remote_onsite, :outside_colorado 

  has_many :tool_sets, class_name: "UsersTools"
  has_many :tools, through: :tool_sets

  has_many :language_sets, class_name: "UsersLanguages"
  has_many :languages, through: :language_sets

  has_many :platform_sets, class_name: "UsersPlatforms"
  has_many :platforms, through: :platform_sets

  has_many :recommendations
  has_many :recommendies, class_name: "Recommendation", foreign_key: "recommendi_id"

  belongs_to :job_type
  validates :username, presence: true, :allow_nil => false, :uniqueness => {:case_sensitive => false}
  validates :email, presence: true, :uniqueness => {:case_sensitive => false}, :allow_nil => false
  validates :experience, numericality: true, :allow_nil => true, inclusion: ALLOWED_EXP_YEARS

  before_save :set_status, :set_username, :set_gravata


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
    self.status = 'Available'
  end

  def set_username
    self.username = self.username.downcase
  end

  def set_gravata
    self.gravatar = "http://1.gravatar.com/avatar/#{Digest::MD5.hexdigest(self.email)}"
  end
end
