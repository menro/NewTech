class CreateEmployeesTypes < ActiveRecord::Migration
  def up
    create_table :employees_types do |t|
      t.string      :name
      t.timestamps
    end
    add_index :employees_types, :name
  end


  def down
    drop_table :employees_types
  end
end
