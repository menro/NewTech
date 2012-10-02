class CreateCounties < ActiveRecord::Migration
  def up
    create_table :counties do |t|
      t.string      :name
      t.string      :state
      t.string      :latitude
      t.string      :longitude
      t.timestamps
    end
    add_index :counties, :name
  end


  def down
    drop_table :counties
  end

end
