class AddJobTypeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :job_type, :string
  end
end
