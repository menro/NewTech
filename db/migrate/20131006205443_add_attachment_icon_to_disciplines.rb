class AddAttachmentIconToDisciplines < ActiveRecord::Migration
  def self.up
    change_table :disciplines do |t|
      t.has_attached_file :icon
    end
  end

  def self.down
    drop_attached_file :disciplines, :icon
  end
end
