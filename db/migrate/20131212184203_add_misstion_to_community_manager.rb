class AddMisstionToCommunityManager < ActiveRecord::Migration
  def change
    add_column :community_managers, :mission, :text
  end
end
