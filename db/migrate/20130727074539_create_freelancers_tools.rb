class CreateFreelancersTools < ActiveRecord::Migration
  def change
    create_table :freelancers_tools do |t|
      t.belongs_to :freelancer
      t.belongs_to :tool

      t.timestamps
    end
    add_index :freelancers_tools, :freelancer_id
    add_index :freelancers_tools, :tool_id
  end
end
