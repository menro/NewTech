class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string      :code
      t.string      :name
      t.attachment  :image
      t.string      :image_token
      t.timestamps
    end
  end
end
