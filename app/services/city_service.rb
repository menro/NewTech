class CityService
  # To change this template use File | Settings | File Templates.
  def self.all
    cities = City.all
    CityDecorator::decorate(cities)
  end

  def self.get_cities_as_options(counties)
    counties.map {|c| ["[#{self.county.name rescue ""}] #{self.name}", c.id]}
  end

  def self.colorado_cities
    state = State.where(name: 'Colorado').first
    state.cities.map{|c| ["[#{c.county.name rescue ""}] #{c.name}", c.id]}
  end

  def self.cities_as_option(state_id)
    state = State.find(state_id)
    state.cities.map{|c| ["[#{c.county.name rescue ""}] #{c.name}", c.id]}
  end

end