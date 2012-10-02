class CreateInvestmentsTypes < ActiveRecord::Migration
  def up
    create_table :investments_types do |t|
      t.string      :name
      t.timestamps
    end
    add_index :investments_types, :name
  end


  def down
    drop_table :investments_types
  end
end
