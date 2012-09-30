ActiveAdmin.register Company do

  # Create sections on the index screen
  scope :all, :default => true

  filter :name
  filter :founded_year

  index do
    column :name
    column :founded_year
    column :enabled
    default_actions
  end

  show do
    render "show"
  end

  form :partial => "form"

end