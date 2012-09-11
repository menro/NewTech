class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string      :code
      t.string      :name
      t.string      :market_color
      t.attachment  :image
      t.timestamps
    end
  end
end
