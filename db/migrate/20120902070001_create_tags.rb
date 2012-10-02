class CreateTags < ActiveRecord::Migration
  def up
    create_table :tags do |t|
      t.string      :name
      t.string      :code
      t.timestamps
    end

    create_table :companies_tags, :id => false do |t|
      t.integer :company_id
      t.integer :tag_id
    end

    add_index :tags, :name
    add_index :tags, :code

    add_index :companies_tags, :company_id
    add_index :companies_tags, :tag_id
  end


  def down
    drop_table :tags
    drop_table :companies_tags
  end
end
