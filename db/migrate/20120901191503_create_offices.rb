class CreateOffices < ActiveRecord::Migration
  def change
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
  end
end
