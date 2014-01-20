class AddCountryIdToState < ActiveRecord::Migration
  def change
    change_table :states do |t|
      t.belongs_to :country
    end
    add_index :states, :country_id
  end
end
