class TwitterNewsService
  
  def self.most_recent(limit=5)
    TwitterNewsDecorator.decorate(TwitterNews.order("tweet_created_at DESC").limit(limit).sort! { |a,b| a.votes <=> b.votes }.reverse!)
  end

end