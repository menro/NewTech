class Category < ActiveRecord::Base

  before_create :generate_image_token

  has_many :companies

  has_attached_file :image,
                    :styles => {
                        :thumb  => "48x48#",
                        :medium => "64x64#"
                    },
                    :path => ':rails_root/uploads/:class/:id_partition/:style.:extension'

  validates_attachment_presence :image

  validates_attachment_size :image, :less_than => 1.megabyte

  validates_attachment_content_type :image,
                                    :content_type => [ 'image/jpeg', 'image/png', 'image/gif' ],
                                    :message => "Is not an acceptable image file"



  private
  def generate_image_token
    found = true
    begin
      random_string = SecureRandom.hex(64)
      found = Category.find_by_image_token random_string
      self.image_token = random_string
    end while found

  end


end
