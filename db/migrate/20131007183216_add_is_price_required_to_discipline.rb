class AddIsPriceRequiredToDiscipline < ActiveRecord::Migration
  def change
    add_column :disciplines, :is_price_required, :boolean, default: true
  end
end
