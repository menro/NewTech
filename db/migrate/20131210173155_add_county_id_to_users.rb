class AddCountyIdToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.belongs_to :county
    end
    add_index :users, :county_id
  end
end
