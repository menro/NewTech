ActiveAdmin.register Discipline do
  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs do
      f.input :name
      f.input :languages_name
      f.input :platforms_name
      f.input :is_price_required, as: :boolean
      f.input :icon, :multipart => true
    end
    f.buttons
  end

  index do
    column :id
    column :name
    column :languages_name
    column :platforms_name
    column :is_price_required
    column :created_at
    column :updated_at
    default_actions
  end

end
