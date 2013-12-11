class CreateCommunityManagers < ActiveRecord::Migration
  def change
    create_table :community_managers do |t|
      t.belongs_to :user
      t.belongs_to :county

      t.timestamps
    end
    add_index :community_managers, :user_id
    add_index :community_managers, :county_id
  end
end
