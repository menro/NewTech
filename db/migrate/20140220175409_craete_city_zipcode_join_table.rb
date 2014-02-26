class CraeteCityZipcodeJoinTable < ActiveRecord::Migration
  def up
    create_table :cities_zipcodes, :id => false do |t|
      t.integer :city_id
      t.integer :zipcode_id
    end

    add_index :cities_zipcodes, [:city_id, :zipcode_id]
  end

  def down
    drop_table :cities_zipcodes
  end
end
