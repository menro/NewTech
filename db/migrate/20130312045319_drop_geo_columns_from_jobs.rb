class DropGeoColumnsFromJobs < ActiveRecord::Migration
  def up
    remove_column :jobs, :address
    remove_column :jobs, :latitude
    remove_column :jobs, :longitude
    remove_column :jobs, :city
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
