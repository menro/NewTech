class CompanyDecorator < Draper::Base
  decorates :company

  def tags_list
    tags.map(&:code).join(", ")
  end

  def full_address
    self.offices.first.full_address rescue "no address"
  end

end
