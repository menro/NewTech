consumer = Category.create do |category|
  category.name  = "Consumer"
  category.code  = "consumer"
  category.marker_color  = "119605"
  category.image = File.new("#{Rails.root}/db/fixtures/files/consumer.png")
end

provider = Category.create do |category|
  category.name  = "Provider"
  category.code  = "provider"
  category.marker_color  = "4681ea"
  category.image = File.new("#{Rails.root}/db/fixtures/files/provider.png")
end

enterprise = Category.create do |category|
  category.name  = "Enterprise"
  category.code  = "enterprise"
  category.marker_color  = "da4747"
  category.image = File.new("#{Rails.root}/db/fixtures/files/enterprise.png")
end

undefined = Category.create do |category|
  category.name  = "Undefined"
  category.code  = "undefined"
  category.marker_color  = "ffc100"
  category.image = File.new("#{Rails.root}/db/fixtures/files/undefined.png")
end