class CreateCities < ActiveRecord::Migration
  def up
    create_table :cities do |t|
      t.belongs_to  :county
      t.string      :name
      t.string      :state
      t.string      :latitude
      t.string      :longitude
      t.timestamps
    end
    add_index :cities, :name
    add_index :cities, :county_id
  end


  def down
    drop_table :cities
  end
end
