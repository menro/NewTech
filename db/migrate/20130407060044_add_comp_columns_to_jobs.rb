class AddCompColumnsToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :hourly_high, :float
    add_column :jobs, :hourly_low, :float
    add_column :jobs, :equity_high, :float
    add_column :jobs, :equity_low, :float
  end
end
