class CreateFreelancers < ActiveRecord::Migration
  def change
    create_table :freelancers do |t|
      t.string :name
      t.string :email
      t.string :jobTitle
      t.integer :experience
      t.string :status
      t.string :github
      t.string :personal_url
      t.string :gravatar
      t.text :bio

      t.timestamps
    end
  end
end
