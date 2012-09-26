ActiveAdmin.register User do

  filter :created_at
  filter :last_name
  filter :nickname
  filter :email

  index do
    column :id
    column :created_at
    column :username
    column :email
    default_actions
  end

  show do
    panel "User Details" do
      attributes_table_for user do
        row :username
        row :email
      end
    end
  end

  form :partial => "form"

end
