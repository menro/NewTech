class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :name
      t.timestamps
    end
    change_table :jobs do |t|
      t.remove :skills
    end
    create_table :jobs_skills, :id => false do |t|
      t.references :job
      t.references :skill
    end
  end
end
