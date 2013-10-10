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
  
  attr_accessible :avatar
  has_attached_file :avatar,
                    :styles => {
                        thumb: "100x100>",
                        icon: "25x25>",
                        regular: "175x175>",
                        small: "35x35>",
                        thumb_large: "75x75>",
                        thumb_small: "55x55>",
                        
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
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me , :role_ids, :job_title, :receive_notification
  attr_accessible :rate, :github, :personal_url, :full_name, :status, :experience, :platform_ids, :language_ids, :address, :town, :zip, :remote_onsite, :outside_colorado, :recommendation_ids, :work_location_ids, :discipline_id, :is_freelancer

  has_many :language_sets, class_name: "UsersLanguages"
  has_many :languages, through: :language_sets

  has_many :platform_sets, class_name: "UsersPlatforms"
  has_many :platforms, through: :platform_sets

  has_many :work_location_types, class_name: "UsersWorkLocations"
  has_many :work_locations, through: :work_location_types, source: :work_location_type

  has_many :recommendations
  has_many :recommendies, class_name: "Recommendation", foreign_key: "recommendi_id"

  # has_many :skills_set, class_name: "UsersSkills"
  # has_many :user_skills, through: :skills_set, source: 'skill_type'

  has_many :users_links
  # belongs_to :job_type
  belongs_to :discipline

  validates :username, presence: true, :allow_nil => false, :uniqueness => {:case_sensitive => false}
  validates :email, presence: true, :uniqueness => {:case_sensitive => false}, :allow_nil => false
  validates :experience, numericality: true, :allow_nil => true, inclusion: ALLOWED_EXP_YEARS


  before_create :set_defualts

  accepts_nested_attributes_for :recommendations

  def is_admin?
    has_role?(:admin)
  end

  def name
    self.full_name.blank? ? self.username : self.full_name
  end

  def reload_skills
    self.user_skills = User.find(self.id).user_skills
  end

  def top_endorsers_count
    recommendies.select(:user_id).group(:user_id).order('count("recommendi_id") DESC').count.count
  end

  def top_endorsers
    recoms = recommendies.select(:user_id).group(:user_id).order('count("recommendi_id") DESC').limit(3)
    users = []
    recoms.each do |r|
      users << User.find(r.user_id)
    end
    users
  end

  def ordered_user_platforms
    # such a messy situation.
    skills = []
    platform_recom = recommendies.where("skillable_type=?", 'Platform').select(:skillable_id).group(:skillable_id).order("COUNT('skillable_id') DESC")
    p_ids = platform_recom.blank? ? [0] : platform_recom.collect(&:skillable_id) || [0]
    platforms = self.platforms.where('platforms.id NOT IN(?) and discipline_id=?', p_ids, self.discipline_id)
    platform_recom.each do |r|
      # p = Platform.where("id IN(?) and discipline_id=?", r.skillable_id, self.discipline_id).first
      p = Platform.where(id: r.skillable_id).first
      skills << p unless p.blank?
    end
    skills + platforms
  end

  def ordered_user_languages
    skills = []
    language_recom = recommendies.where("skillable_type=?", 'Language').select(:skillable_id).group(:skillable_id).order("COUNT('skillable_id') DESC")
    l_ids = language_recom.blank? ? [0] : language_recom.collect(&:skillable_id)
    languages = self.languages.where('languages.id NOT IN(?) and discipline_id=?', l_ids, self.discipline_id)
    language_recom.each do |r|
      # l = Language.where("id IN(?) and discipline_id=?", r.skillable_id, self.discipline_id).first
      l = Language.where(id: r.skillable_id).first
      skills << l unless l.blank?
    end
    skills + languages
  end

  def endorsed_this?(skill, freelancer)
    rec = self.recommendations.where("skillable_id=? and recommendi_id=? and skillable_type=?", skill.id, freelancer.id, skill.class.name)
    rec.present?
  end

  def self.browse_all
    users_status = []
    User::WORK_STATUS.each do |status|
      users = []
      users = User.where('is_freelancer=? and status =? ', true, status)
      users_status << [status, users.uniq]
    end
    users_status
  end

  def self.allowed_languages_as_options 
    Language.all.map {|t| [t.name.titleize, t.id]}
  end
  
  def self.allowed_platforms_as_options
    Platform.all.map {|t| [t.name.titleize, t.id]}
  end
  
  def self.allowed_work_status_as_options
    WORK_STATUS.map {|t| [t.titleize, t]}
  end
  
  def self.allowed_work_onsite_as_options
    WorkLocationType.all.map { |t| [t.name.titleize, t.id]}
  end
  
  def self.allowed_user_rates_as_options
    USER_RATES.map { |t| [t, t]}
  end

  def self.allowed_disciplines_as_options
    discipline = Discipline.where(name: 'Developer').first
    [[discipline.name.titleize, discipline.id]] + Discipline.where("id !=?", discipline.id).all.map { |d| [d.name.titleize, d.id]}
  end


  private

  def set_defualts
    self.status = self.status || 'available'
    self.experience = self.experience || 0
    self.gravatar = "http://1.gravatar.com/avatar/#{Digest::MD5.hexdigest(self.email)}"
    self.username = self.username.downcase.gsub(/\s/,'')
  end

  def self.languages_in(language)
    Language.where("id in(?)", language)
  end
  search_methods :languages_in
end
