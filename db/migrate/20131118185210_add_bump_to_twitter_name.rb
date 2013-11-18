class AddBumpToTwitterName < ActiveRecord::Migration
  def change
    add_column :twitter_names, :bump, :integer, default: 0
  end
end
