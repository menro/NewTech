class CreateCountiesZipcodesJoinTable < ActiveRecord::Migration
  def up
    create_table :counties_zipcodes, :id => false do |t|
      t.integer :county_id
      t.integer :zipcode_id
    end

    add_index :counties_zipcodes, [:county_id, :zipcode_id]
  end

  def down
    drop_table :counties_zipcodes
  end
end
