class AddColumnsToSponsors < ActiveRecord::Migration
  def change
    add_column :sponsors, :image_file_name, :string
    add_column :sponsors, :image_content_type, :string
    add_column :sponsors, :image_file_size, :string
  end
end
