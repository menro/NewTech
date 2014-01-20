class AddBumpToTwitterNews < ActiveRecord::Migration
  def change
    add_column :twitter_news, :bump, :integer, default: 0
  end
end
