class CreateRoles < ActiveRecord::Migration
  def up
    create_table(:roles) do |t|
      t.string :name
      t.references :resource, :polymorphic => true

      t.timestamps
    end

    create_table(:users_roles, :id => false) do |t|
      t.references :user
      t.references :role
    end

    add_index :roles, :name
    add_index :users_roles, :user_id
    add_index :users_roles, :role_id
  end


  def down
    drop_table :users_roles
    drop_table :roles
  end
end
