class AddColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :is_freelancer, :boolean, default: false
  end
end
