class CategoryService

  def self.all
    categories = CategoryDecorator.all
    CategoryDecorator.decorate(categories)
  end

  def self.enabled
    categories = CategoryDecorator.where("code != 'undefined'")
    CategoryDecorator.decorate(categories)
  end

  def self.find(id)
    category = CategoryDecorator.find(1)
    CategoryDecorator.decorate(category)
  end

end