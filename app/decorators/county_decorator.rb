class CountyDecorator < Draper::Base
  decorates :county


  def offices_numbers
    self.offices.count
  end

  def offices_percentage
    ((offices_numbers * 100).to_f / Office.count.to_f).to_f
  end

end
