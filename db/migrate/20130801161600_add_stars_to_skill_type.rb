class AddStarsToSkillType < ActiveRecord::Migration
  def change
    add_column :skill_types, :stars, :integer
  end
end
