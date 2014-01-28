class CreateZipcodes < ActiveRecord::Migration
  def change
    create_table :zipcodes do |t|
      t.string :code
      t.string :longitude
      t.string :latitude

      t.timestamps
    end
  end
end
