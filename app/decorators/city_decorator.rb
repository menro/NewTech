class CityDecorator < Draper::Base
  decorates :city


  def name_for_select
    "[#{self.county.name rescue ""}] #{self.name}"
  end
end
