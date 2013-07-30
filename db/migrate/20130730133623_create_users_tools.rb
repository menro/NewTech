class CreateUsersTools < ActiveRecord::Migration
  def change
    create_table :users_tools do |t|
      t.belongs_to :user
      t.belongs_to :tool

      t.timestamps
    end
    add_index :users_tools, :user_id
    add_index :users_tools, :tool_id
  end
end
