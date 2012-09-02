class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string      :name
      t.string      :code
      t.timestamps
    end
    create_table :companies_tags, :id => false do |t|
      t.integer :company_id
      t.integer :tag_id
    end
  end
end
