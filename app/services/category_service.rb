class CategoryService

  def self.all
    CategoryDecorator.all
  end

  def self.enabled
    CategoryDecorator.where("code != 'undefined'")
  end

  def self.find(id)
    CategoryDecorator.find id
  end

end