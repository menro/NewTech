class AddShortNameToState < ActiveRecord::Migration
  def change
    add_column :states, :short_name, :string
  end
end
