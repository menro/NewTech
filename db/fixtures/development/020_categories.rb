consumer = Category.create do |category|
  category.name  = "Consumer"
  category.code  = "consumer"
  category.image = File.new("#{Rails.root}/db/fixtures/files/consumer.png")
end

provider = Category.create do |category|
  category.name  = "Provider"
  category.code  = "provider"
  category.image = File.new("#{Rails.root}/db/fixtures/files/provider.png")
end

enterprise = Category.create do |category|
  category.name  = "Enterprise"
  category.code  = "enterprise"
  category.image = File.new("#{Rails.root}/db/fixtures/files/enterprise.png")
end

undefined = Category.create do |category|
  category.name  = "Undefined"
  category.code  = "undefined"
  category.image = File.new("#{Rails.root}/db/fixtures/files/undefined.png")
end