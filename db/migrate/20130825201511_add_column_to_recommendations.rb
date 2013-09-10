class AddColumnToRecommendations < ActiveRecord::Migration
  def change
    change_table :recommendations do |t|
      t.references :skillable, polymorphic: true
    end
    add_index :recommendations, :skillable_id
  end
end
