class CreateRecommendations < ActiveRecord::Migration
  def change
    create_table :recommendations do |t|
      t.belongs_to :user
      t.belongs_to :skill_type
      t.integer :recommendi_id

      t.timestamps
    end
    add_index :recommendations, :user_id
    add_index :recommendations, :skill_type_id
  end
end
