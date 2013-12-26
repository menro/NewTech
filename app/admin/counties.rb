ActiveAdmin.register County  do
  form do |f|
    f.inputs do
      f.input :name
      f.input :state, as: :select, collection: StateService::all
      f.input :longitude
      f.input :latitude
    end

    f.buttons
  end
end
