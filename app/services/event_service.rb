class EventService

  def self.all
    events = Event.where("start_at >= ?", Time.now).order('start_at ASC')
    EventDecorator::decorate(events)
  end

  def self.find_next
    event = Event.where("start_at >= ?", Time.now).first
    EventDecorator.decorate(event) unless event.nil?
  end

end