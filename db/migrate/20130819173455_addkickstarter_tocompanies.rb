class AddkickstarterTocompanies < ActiveRecord::Migration
  def change
    add_column :companies, :kickstarter_url, :string
    add_column :companies, :kickstarter_end_date, :datetime
  end
end
