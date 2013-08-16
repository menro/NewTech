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

  attr_accessible :avatar
  has_attached_file :avatar,
                    :styles => {
                        thumb: "100x100>",
                        icon: "25x25>",
                        regular: "180x180>"
                    },
                    :default_url => "http://b.dryicons.com/images/icon_sets/colorful_stickers_icons_set/png/256x256/help.png",
                    :storage => :s3,
                    :s3_protocol => 'https',
                    :s3_permissions => :public_read,
                    :bucket => configatron.s3.bucket,
                    :s3_credentials => {
                        :access_key_id => configatron.s3.credentials.access_key_id,
                        :secret_access_key => configatron.s3.credentials.secret_access_key
                    },
                    :path => "/#{Rails.env}/:class/:id/:style.:extension"
  
  validates_attachment_size :avatar, :less_than => 1.megabyte
  validates_attachment_content_type :avatar, :content_type => /image/

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

  before_save :set_status, :set_username, :set_gravata #, :reload_skills

  accepts_nested_attributes_for :recommendations

  def is_admin?
    has_role?(:admin)
  end

  def name
    self.full_name.blank? ? self.username : self.full_name
  end

  def job_title
    job_type.try(:name) || ""
  end

  def reload_skills
    self.user_skills = User.find(self.id).user_skills
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

  def self.platforms_in(platforms)
    # users = []
    # platf = Platform.where("id in(?)", platforms)
    # platf.each do |p|
    #   users << p.users
    # end
    # users
    Platform.where("id in(?)", platforms)
  end
  search_methods :platforms_in

  def self.languages_in(language)
    Language.where("id in(?)", language)
  end
  search_methods :languages_in
end
