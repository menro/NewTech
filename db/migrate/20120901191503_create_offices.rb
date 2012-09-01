class CreateOffices < ActiveRecord::Migration
  def change
    create_table :offices do |t|
      t.belongs_to  :company
      t.string      :description
      t.string      :address1
      t.string      :address2
      t.string      :zip_code
      t.string      :city
      t.string      :state_code
      t.string      :country_code
      t.string      :latitude
      t.string      :longitude
      t.timestamps
    end
  end
end
