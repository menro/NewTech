class Category < ActiveRecord::Base

  has_many :companies

  has_many :offices, :through => :companies

  has_attached_file :image,
                    :styles => {
                        :cluster1 => "48x48#",
                        :cluster2 => "64x64#",
                        :cluster3 => "80x80#",
                        :cluster4 => "96x96#",
                        :cluster5 => "112x112#",
                        :cluster6 => "256x256#"
                    },
                    :url  => ':class/:id/image/:style',
                    :path => ':rails_root/uploads/:class/:id_partition/:style.:extension'

  validates_attachment_presence :image

  validates_attachment_size :image, :less_than => 1.megabyte

  validates_attachment_content_type :image,
                                    :content_type => [ 'image/jpeg', 'image/png', 'image/gif' ],
                                    :message => "Is not an acceptable cluster_image file"


end
