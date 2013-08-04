class CreateWorkLocationTypes < ActiveRecord::Migration
  def change
    create_table :work_location_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
