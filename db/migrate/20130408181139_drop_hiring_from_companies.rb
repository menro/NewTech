class DropHiringFromCompanies < ActiveRecord::Migration
  def change
    change_table :companies do |t|
      t.remove :hiring
    end
  end
end
