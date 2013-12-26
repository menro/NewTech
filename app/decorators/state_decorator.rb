class StateDecorator < Draper::Base
  decorates :state

  def name_for_select
    "#{self.name}"
  end

end