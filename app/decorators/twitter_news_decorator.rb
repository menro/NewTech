class TwitterNewsDecorator < Draper::Base

  decorates :twitter_news

  def title
    news_title
  end
  
  def truncated_title
    (title.length > 41) ? (title.slice(0, 35) + "...") : title
  end

  def url
    news_url
  end

  def publisher_thumbnail_url
    publisher_image_url || 'http://b.dryicons.com/images/icon_sets/colorful_stickers_icons_set/png/256x256/help.png'
  end

end