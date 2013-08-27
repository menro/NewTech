class AddColumnToLanguages < ActiveRecord::Migration
  def change
    add_column :languages, :on_page, :boolean, default:false
  end
end
