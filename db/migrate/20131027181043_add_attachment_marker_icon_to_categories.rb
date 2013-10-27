class AddAttachmentMarkerIconToCategories < ActiveRecord::Migration
  def self.up
    change_table :categories do |t|
      t.has_attached_file :marker_icon
    end
  end

  def self.down
    drop_attached_file :categories, :marker_icon
  end
end
