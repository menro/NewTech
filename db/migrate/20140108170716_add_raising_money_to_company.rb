class AddRaisingMoneyToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :raising_money, :boolean, default: false
  end
end
