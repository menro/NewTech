class AddJobsCountToCities < ActiveRecord::Migration

  def up
    add_column :cities, :jobs_count, :integer
    City.reset_column_information
    City.find_each do |c|
      City.update_counters c.id, jobs_count: c.jobs.length
    end
  end

  def down
    remove_column :cities, :jobs_count
  end

end
