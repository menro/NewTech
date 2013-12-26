class CityService
  # To change this template use File | Settings | File Templates.
  def self.all
    cities = City.all
    CityDecorator::decorate(cities)
  end

  def self.get_cities_as_options(counties)
    counties.map {|c| ["[#{self.county.name rescue ""}] #{self.name}", c.id]}
  end
end