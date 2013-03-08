class Sponsor < ActiveRecord::Base
  attr_accessible :image, :name, :url,:image_file_name, :image_content_type, :image_file_size

  validates_presence_of :name, :url
  
  has_attached_file :image,
    :styles => {
    :thumbnail => "160x120>"
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
    :path => "/:class/:id/:style.:extension"


  validates_attachment_size :image, :less_than => 1.megabyte
  #  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png']


  def get_image
    url =  "http://b.dryicons.com/images/icon_sets/colorful_stickers_icons_set/png/256x256/help.png"
    if self.image.present?
      url = self.image
    end
    url
  end

  def self.get_randomly
    return '' if Sponsor.count == 0
    id = 0
    ids = Sponsor.select('id').collect(&:id)
    id = ids[Random.rand(ids.count+1)] while id == 0 || id.blank?
    Sponsor.find(id)
  end
end
