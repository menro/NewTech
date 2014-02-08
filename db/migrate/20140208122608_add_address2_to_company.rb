class AddAddress2ToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :address2, :string
  end
end
