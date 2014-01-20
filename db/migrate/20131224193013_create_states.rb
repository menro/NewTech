class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :name
      t.string :country
      t.string :longitude
      t.string :latitude

      t.timestamps
    end
  end
end
