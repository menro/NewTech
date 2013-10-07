class Discipline < ActiveRecord::Base

  default_scope order("name ASC")

  attr_accessible :name, :platforms_name, :languages_name, :icon, :is_price_required

  has_many :languages
  has_many :platforms


  has_attached_file :icon,
                    :styles => {
                        small: "24x18>"
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
end
