class AddMoneyRaisingExpiredAtToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :money_raisig_expired_at, :datetime
  end
end
