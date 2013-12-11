ActiveAdmin.register User do

  menu :priority => 1

  filter :created_at
  filter :last_name
  filter :nickname
  filter :email
  filter :is_freelancer

  index do
    column :id
    column :created_at
    column :username
    column :email
    column :is_freelancer
    column :profile_views
    default_actions
  end

  show do
    panel "User Details" do
      attributes_table_for user do
        row :username
        row :email
        row :is_freelancer
        row :profile_views
      end
    end
  end

  form :partial => "form"

end
