class TagService

  def self.all
    #TODO restituire non tutti ma quelli che superano una soglia minima di occorrenze (companies_count)
    tags = TagDecorator.all
    TagDecorator.decorate(tags)
  end

end