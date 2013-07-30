class CreateUsersPlatforms < ActiveRecord::Migration
  def change
    create_table :users_platforms do |t|
      t.belongs_to :user
      t.belongs_to :platform

      t.timestamps
    end
    add_index :users_platforms, :user_id
    add_index :users_platforms, :platform_id
  end
end
