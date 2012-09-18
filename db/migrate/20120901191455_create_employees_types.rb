class CreateEmployeesTypes < ActiveRecord::Migration
  def change
    create_table :employees_types do |t|
      t.string      :name
      t.timestamps
    end
  end
end
