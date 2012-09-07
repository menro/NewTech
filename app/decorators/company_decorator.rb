class CompanyDecorator < Draper::Base
  decorates :company

  def tags_list
    tags.map(&:code).join(", ")
  end

end
