ActiveAdmin.register Sponsor do

  form :html => { :enctype => "multipart/form-data" } do |f|
  f.inputs do
    f.input :name
    f.input :url
    f.input :image, :multipart => true
    
  end
  f.buttons
end

end
