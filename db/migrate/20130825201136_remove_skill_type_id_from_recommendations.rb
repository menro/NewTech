class RemoveSkillTypeIdFromRecommendations < ActiveRecord::Migration
  def up
    remove_column :recommendations, :skill_type_id
  end

  def down
    add_column :recommendations, :skill_type_id, :belongs_to
  end
end
