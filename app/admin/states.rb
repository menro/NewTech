ActiveAdmin.register State do

  form do |f|
    f.inputs 'Details' do
      f.input :name
      f.input :country, :as => :string
      f.input :longitude
      f.input :latitude
    end
    f.actions
  end

end
