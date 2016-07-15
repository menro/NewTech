State::DEFAULTS.each do |name|

  State.create do |s|
    s.country =  Country.find_by_name( Country::DEFAULT )
    s.name = name
  end unless State.find_by_name name

end
