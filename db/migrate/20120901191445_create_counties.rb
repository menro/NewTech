class CreateCounties < ActiveRecord::Migration
  def change
    create_table :counties do |t|
      t.string      :name
      t.string      :state
      t.string      :latitude
      t.string      :longitude
      t.timestamps
    end
  end
end
