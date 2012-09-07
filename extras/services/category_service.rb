class CategoryService

  def self.all
    CategoryDecorator.all
  end

  def self.find(id)
    CategoryDecorator.find id
  end

end