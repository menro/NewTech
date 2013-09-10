class AddMoreColumnsToLanguages < ActiveRecord::Migration
  
  def self.up
    change_table :languages do |t|
      t.belongs_to :discipline
    end
    add_index :languages, :discipline_id
  end

end
