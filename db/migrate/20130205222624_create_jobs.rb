class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :kind
      t.string :role
      t.string :skills
      t.integer :salary_low
      t.integer :salary_high
      t.string :address
      t.string :city
      t.string :zip_code
      t.references :company
      t.references :city
      t.float :latitude
      t.float :longitude
      t.timestamps
    end
  end
end
