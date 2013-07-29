class CreateSkillsEndorsements < ActiveRecord::Migration
  def change
    create_table :skills_endorsements do |t|
      t.belongs_to :user
      t.belongs_to :job_type
      t.string :rate
      t.string :ratings

      t.timestamps
    end
    add_index :skills_endorsements, :user_id
    add_index :skills_endorsements, :job_type_id
  end
end
