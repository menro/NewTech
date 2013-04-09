class AddJobsCountToCompanies < ActiveRecord::Migration

  def up
    add_column :companies, :jobs_count, :integer
    Company.reset_column_information
    Company.find_each do |c|
      Company.update_counters c.id, jobs_count: c.jobs.length
    end
  end

  def down
    remove_column :companies, :jobs_count
  end

end
