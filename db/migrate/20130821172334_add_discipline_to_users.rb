class AddDisciplineToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.belongs_to :discipline
    end
    add_index :users, :discipline_id
  end
end
