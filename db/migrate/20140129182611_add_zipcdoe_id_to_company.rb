class AddZipcdoeIdToCompany < ActiveRecord::Migration
  def change
    change_table :companies do |t|
      t.belongs_to :zipcode
    end
    add_index :companies, :zipcode_id
  end
end
