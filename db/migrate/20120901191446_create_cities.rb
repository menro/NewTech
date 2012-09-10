class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.belongs_to  :county
      t.string      :name
      t.string      :state
      t.string      :latitude
      t.string      :longitude
      t.timestamps
    end
  end
end
