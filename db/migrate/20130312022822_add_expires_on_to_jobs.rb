class AddExpiresOnToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :expires_on, :datetime
  end
end
