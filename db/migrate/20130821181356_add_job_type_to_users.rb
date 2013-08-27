class AddJobTypeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :job_title, :string
  end
end
