ActiveAdmin.register Language do
  menu parent: 'Disciplines'

  form do |f|
    f.object.errors.full_messages
    f.inputs do
      f.input :name
      f.input :discipline, as: :select, collection: User.allowed_disciplines_as_options
      f.input :on_page, as: :boolean
    end

    f.actions
  end

  index do
    selectable_column
    column :id
    column :name
    column :discipline do |language|
      language.discipline.name
    end
    column :on_page
    default_actions
  end

  show do |language|
    attributes_table do
      row :id
      row :name
      row :discipline do |language|
        language.discipline.name
      end
      row :on_page
      row :created_at
      row :updated_at
    end
  end

end
