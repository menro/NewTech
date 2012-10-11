class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.string :marker_image
      t.text :description

      t.timestamps
    end
  end
end
