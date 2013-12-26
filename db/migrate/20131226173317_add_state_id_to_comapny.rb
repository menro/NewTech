class AddStateIdToComapny < ActiveRecord::Migration
  def change
    change_table :companies do |t|
      t.belongs_to :state
    end
    add_index :companies, :state_id
  end
end
