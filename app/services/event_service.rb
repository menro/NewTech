class EventService

  def self.find_next
    Event.where("start_at >= ?", Time.now).first
  end

end