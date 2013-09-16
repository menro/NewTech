class AddMoreColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :receive_notification, :boolean, default: true
  end
end
