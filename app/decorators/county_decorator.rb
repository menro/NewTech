class CountyDecorator < Draper::Base
  decorates :county


  def offices_numbers
    self.offices.count
  end

  def offices_percentage
    ((offices_numbers * 100).to_f / Office.count.to_f).to_f
  end

  def offices_avg_latitude
    self.offices.average(:latitude)
  end

  def offices_avg_longitude
    self.offices.average(:longitude)
  end

end
