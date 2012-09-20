class OfficeDecorator < Draper::Base
  decorates :office


  def company_image_url
    h.image_company_url(self.company, :medium)
  end
end
