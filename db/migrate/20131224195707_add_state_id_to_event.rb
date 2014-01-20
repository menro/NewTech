class AddStateIdToEvent < ActiveRecord::Migration

  def change
    change_table :events do |t|
      t.belongs_to :state
    end
    add_index :events, :state_id
  end

end
