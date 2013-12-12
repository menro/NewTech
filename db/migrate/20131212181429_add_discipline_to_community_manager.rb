class AddDisciplineToCommunityManager < ActiveRecord::Migration
  def change
    change_table :community_managers do |t|
      t.belongs_to :discipline
    end
    add_index :community_managers, :discipline_id
  end

end
