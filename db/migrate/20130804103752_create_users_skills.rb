class CreateUsersSkills < ActiveRecord::Migration
  def change
    create_table :users_skills do |t|
      t.belongs_to :user
      t.belongs_to :skill_type

      t.timestamps
    end
    add_index :users_skills, :user_id
    add_index :users_skills, :skill_type_id
  end
end
