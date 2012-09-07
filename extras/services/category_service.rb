class CategoryService

  def self.all
    Category.all
  end

  def self.find(id)
    Category.find id
  end

end