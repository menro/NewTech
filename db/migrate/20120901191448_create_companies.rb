class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.belongs_to  :user
      t.string      :name
      t.string      :permalink
      t.string      :homepage_url
      t.string      :blog_url
      t.string      :category_code
      t.string      :number_of_employees
      t.string      :founded_year
      t.string      :email_address
      t.string      :phone_number
      t.string      :description
      t.text        :overview
      t.timestamps
    end
  end
end
