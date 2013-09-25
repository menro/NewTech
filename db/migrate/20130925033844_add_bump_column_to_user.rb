class AddBumpColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :bump, :integer, default: 0
  end
end
