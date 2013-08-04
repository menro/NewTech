class CreateUsersWorkLocations < ActiveRecord::Migration
  def change
    create_table :users_work_locations do |t|
      t.belongs_to :user
      t.belongs_to :work_location_type

      t.timestamps
    end
    add_index :users_work_locations, :user_id
    add_index :users_work_locations, :work_location_type_id
  end
end
