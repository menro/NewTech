class CreateInvestmentsTypes < ActiveRecord::Migration
  def change
    create_table :investments_types do |t|
      t.string      :name
      t.timestamps
    end
  end
end
