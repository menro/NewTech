class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string      :code
      t.timestamps
    end
  end
end
