class CreateFreelancersLanguages < ActiveRecord::Migration
  def change
    create_table :freelancers_languages do |t|
      t.belongs_to :freelancer
      t.belongs_to :language

      t.timestamps
    end
    add_index :freelancers_languages, :freelancer_id
    add_index :freelancers_languages, :language_id
  end
end
