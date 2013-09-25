class CreateFreelancerConfigs < ActiveRecord::Migration
  def change
    create_table :freelancer_configs do |t|
      t.integer :bump
      t.integer :endorse_count

      t.timestamps
    end
  end
end
