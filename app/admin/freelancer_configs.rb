ActiveAdmin.register FreelancerConfig do
  
  index do
    column :id
    column :created_at
    column :bump
    column :endorse_count
    default_actions
  end

  show do
    panel "FreelancerConfig Details" do
      attributes_table_for freelancer_config do
        row :bump
        row :endorse_count
      end
    end
  end

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs do
      f.input :bump
      f.input :endorse_count
    end
    f.buttons
  end
end
