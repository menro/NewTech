class CityService
  # To change this template use File | Settings | File Templates.
  def self.all
    cities = City.all
    CityDecorator::decorate(cities)
  end
end