class EventService

  def self.all
    events = Event.all
    EventDecorator::decorate(events)
  end

  def self.find_next
    event = Event.where("start_at >= ?", Time.now).first
    EventDecorator.decorate(event) unless event.nil?
  end

  def self.search(params)
    events = Event.where(county_id: params[:current_county_id]).all
    EventDecorator.decorate(events) unless events.nil?
  end

end