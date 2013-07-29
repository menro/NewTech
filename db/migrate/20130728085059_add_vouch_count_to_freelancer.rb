class AddVouchCountToFreelancer < ActiveRecord::Migration
  def change
    add_column :freelancers, :vouch_count, :integer
  end
end
