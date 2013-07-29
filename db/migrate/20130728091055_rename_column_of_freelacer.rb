class RenameColumnOfFreelacer < ActiveRecord::Migration
  def change
    rename_column :freelancers, :jobTitle, :job_title
  end
end
