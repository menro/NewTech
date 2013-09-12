class AddMorColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :is_company, :boolean, default: true
  end
end
