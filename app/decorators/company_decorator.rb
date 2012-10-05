class CompanyDecorator < Draper::Base
  decorates :company

  def full_address
    "no address"
  end

  def image_url
    h.image_company_url(self, :thumbnail)
  end

end
