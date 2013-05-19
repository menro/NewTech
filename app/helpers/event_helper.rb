module EventHelper
  def events_with_groups(events,size)
    evnts = []
    group = []
    events.each_with_index do |event, idx|
      if idx % size == 0 && idx != 0
        evnts.push(group)
        group = []
      end
      group.push(event)
      evnts.push(group) if events.size <= 3
    end
    evnts
  end

end