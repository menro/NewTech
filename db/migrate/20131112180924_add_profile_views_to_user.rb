class AddProfileViewsToUser < ActiveRecord::Migration
  def change
    add_column :users, :profile_views, :integer, default: 0
  end
end
