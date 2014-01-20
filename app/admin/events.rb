ActiveAdmin.register Event do
  
  form do |f|
    f.inputs do
      f.input :title
      f.input :preview
      f.input :start_at
      f.input :county
    end
    f.buttons
  end
end
