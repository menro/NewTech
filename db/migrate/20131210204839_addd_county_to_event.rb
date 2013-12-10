class AdddCountyToEvent < ActiveRecord::Migration
  def change
    change_table :events do |t|
      t.belongs_to :county
    end
    add_index :events, :county_id
  end
end
