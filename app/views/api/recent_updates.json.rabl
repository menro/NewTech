object false

child @recent_updates => :recent_updates do
attributes  :id, :name, :county_name

node(:image) { |company| company.image.url }
end
