class AddMoreColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :endorsers_count, :integer, default: 0
  end
end
