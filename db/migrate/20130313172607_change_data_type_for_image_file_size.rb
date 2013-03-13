class ChangeDataTypeForImageFileSize < ActiveRecord::Migration
  def change
    change_table :sponsors do |t|
      t.change :image_file_size, :integer
    end
  end
end