class TwitterNewsService
  
  def self.most_recent(limit=5)
    TwitterNewsDecorator.decorate(TwitterNews.order("tweet_created_at DESC").limit(100).sort! { |a,b| a.votes <=> b.votes }.reverse!.first(limit))
  end

  def self.search(limit=5)
    TwitterNewsDecorator.decorate(TwitterNews.order("tweet_created_at DESC").limit(100).sort! { |a,b| a.votes <=> b.votes }.reverse!.first(limit))
  end
  
end