class AddStateIdToCounty < ActiveRecord::Migration
  def change
    change_table :counties do |t|
      t.belongs_to :state
    end
    add_index :counties, :state_id
  end
end
