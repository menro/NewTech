class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :experience, :integer
    add_column :users, :status, :string
    add_column :users, :github, :string
    add_column :users, :personal_url, :string
    add_column :users, :gravatar, :string
    add_column :users, :bio, :text
    add_column :users, :vouch_count, :integer
  end
end
