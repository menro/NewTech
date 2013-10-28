class CompanyDecorator < Draper::Base
  decorates :company

  def full_address
    "#{self.address}, #{self.city.name}"
  end

  def image_url
    self.image(:thumbnail)
  end

  def category_marker_image
    # category.marker_image
    category.marker_icon(:small)
  end

end
