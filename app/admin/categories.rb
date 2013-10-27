ActiveAdmin.register Category do
    
  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs do
      f.input :name
      f.input :marker_icon, :multipart => true
      f.input :description
    end
    f.buttons
  end

end
