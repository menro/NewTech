class AddLinkAndEmailToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :link, :string
    add_column :jobs, :email, :string
  end
end
