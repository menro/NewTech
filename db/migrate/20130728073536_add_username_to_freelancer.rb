class AddUsernameToFreelancer < ActiveRecord::Migration
  def change
    add_column :freelancers, :username, :string
  end
end
