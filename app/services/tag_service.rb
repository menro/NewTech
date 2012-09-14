class TagService

  def self.tags_for_cloud
    #restituisce quelli che superano una soglia minima di occorrenze (companies.count)
    tags = TagDecorator.all.reject do |tag|
      tag.companies_count <= 1
    end
    TagDecorator.decorate(tags)
  end

end