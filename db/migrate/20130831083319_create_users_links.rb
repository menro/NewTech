class CreateUsersLinks < ActiveRecord::Migration
  def change
    create_table :users_links do |t|
      t.belongs_to :user
      t.string :link_url
      t.string :name

      t.timestamps
    end
    add_index :users_links, :user_id
  end
end
