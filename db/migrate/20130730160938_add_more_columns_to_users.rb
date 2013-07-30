class AddMoreColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :address, :string
    add_column :users, :town, :string
    add_column :users, :zip, :string
    add_column :users, :remote_onsite, :string
    add_column :users, :outside_colorado, :boolean
  end
end
