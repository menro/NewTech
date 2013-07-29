class Freelancer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable

  ALLOWED_EXP_YEARS = 0..50
  
  ALLOWED_TOOLS_AS_OPTIONS = Tool.all.map {|t| [t.name.titleize, t.id]}
  ALLOWED_LANGUAGES_AS_OPTIONS = Language.all.map {|t| [t.name.titleize, t.id]}
  ALLOWED_PLATFORMS_AS_OPTIONS = Platform.all.map {|t| [t.name.titleize, t.id]}

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :confirmable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :password, :password_confirmation, :remember_me
  attr_accessible :bio, :email, :experience, :github, :gravatar, :jobTitle, :name, :personal_url, :status, :tool_ids, :language_ids, :platform_ids, :username

  has_many :tool_sets, class_name: "FreelancersTools"
  has_many :tools, through: :tool_sets

  has_many :language_sets, class_name: "FreelancersLanguages"
  has_many :languages, through: :language_sets

  has_many :platform_sets, class_name: "FreelancersPlatforms"
  has_many :platforms, through: :platform_sets
  
  validates :username, presence: true, :allow_nil => false, :uniqueness => {:case_sensitive => false}
  validates :email, presence: true, :uniqueness => {:case_sensitive => false}, :allow_nil => false
  validates :experience, presence: true, numericality: true, :allow_nil => true, inclusion: ALLOWED_EXP_YEARS

  before_save :set_status, :set_username, :set_gravata

  private

  def set_status
    self.status = 'Available'
  end

  def set_username
    self.username = self.username.downcase
  end

  def set_gravata
    self.gravatar = "http://1.gravatar.com/avatar/#{Digest::MD5.hexdigest(self.email)}?s=180"
  end
end
