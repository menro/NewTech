ActiveAdmin.register Company do

  # Create sections on the index screen
  scope :all, :default => true
  scope :are_hiring

  filter :name
  filter :founded_year

  index do
    column :id
    column :name
    column :founded_year
    column :enabled
    default_actions
  end

end
