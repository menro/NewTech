class AddColumnsToDiscipline < ActiveRecord::Migration
  def change
    add_column :disciplines, :languages_name, :string, default: 'Languages'
    add_column :disciplines, :platforms_name, :string, default: 'Platforms'
  end
end
