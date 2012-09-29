class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.belongs_to  :user
      t.belongs_to  :employees_type
      t.belongs_to  :investments_type
      t.string      :name
      t.string      :permalink
      t.boolean     :hiring
      t.boolean     :enabled
      t.boolean     :presented
      t.date        :presentation_date
      t.string      :homepage_url
      t.string      :facebook
      t.string      :twitter
      t.string      :jobs_url
      t.string      :founded_year
      t.string      :email_address
      t.string      :phone_number
      t.text        :description
      t.text        :overview
      t.attachment  :image
      t.timestamps
    end
  end
end
