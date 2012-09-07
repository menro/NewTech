class CategoryDecorator < Draper::Base
  decorates :category

  def cluster_styles
    results = {}
    image.styles.each do |k, v|
      results[k] = "#{image.url(k)}"
    end
    results
  end

end
