class CategoryDecorator < Draper::Base
  decorates :category


  def cluster_styles
    results = []
    image.styles.each do |k, v|
      height, width = v.geometry.gsub!("#","").split("x")
      result = {}
      result[:url] = h.image_category_url(id,k)
      result[:height] = height
      result[:width] = width
      result[:textColor] = "#ffffff"
      result[:textSize]  = 10
      results << result
    end
    results
  end

end
