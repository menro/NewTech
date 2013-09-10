class AddMoreColumnsToPlatforms < ActiveRecord::Migration
  
  def self.up
    change_table :platforms do |t|
      t.belongs_to :discipline
    end
    add_index :platforms, :discipline_id
  end

end
