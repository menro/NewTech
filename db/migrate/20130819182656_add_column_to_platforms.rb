class AddColumnToPlatforms < ActiveRecord::Migration
  def change
    add_column :platforms, :on_page, :boolean, default: false
  end
end
