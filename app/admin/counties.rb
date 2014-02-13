ActiveAdmin.register County  do


  filter :name
  filter :state_id, :collection => proc { State.all }, :as => :select

  form do |f|
    f.inputs do
      f.input :name
      f.input :state_id, as: :select, collection: StateService::all
      f.input :longitude
      f.input :latitude
    end

    f.buttons
  end
end
