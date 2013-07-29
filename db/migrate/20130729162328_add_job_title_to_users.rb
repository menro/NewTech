class AddJobTitleToUsers < ActiveRecord::Migration


  def up
    change_table :users do |t|
      t.belongs_to :job_type
    end
    add_index :users, :job_type_id
  end
end
