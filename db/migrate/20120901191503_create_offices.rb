class CreateOffices < ActiveRecord::Migration
  def up
    create_table :offices do |t|
      t.belongs_to  :company
      t.belongs_to  :city
      t.string      :description
      t.string      :address1
      t.string      :address2
      t.string      :zip_code
      t.string      :latitude
      t.string      :longitude
      t.timestamps
    end
    add_index :offices, :company_id
    add_index :offices, :city_id
  end


  def down
    drop_table :offices
  end
end
