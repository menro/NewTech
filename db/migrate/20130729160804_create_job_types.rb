class CreateJobTypes < ActiveRecord::Migration
  def change
    create_table :job_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
