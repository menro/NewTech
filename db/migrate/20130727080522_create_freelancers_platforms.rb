class CreateFreelancersPlatforms < ActiveRecord::Migration
  def change
    create_table :freelancers_platforms do |t|
      t.belongs_to :freelancer
      t.belongs_to :platform

      t.timestamps
    end
    add_index :freelancers_platforms, :freelancer_id
    add_index :freelancers_platforms, :platform_id
  end
end
