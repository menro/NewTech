ActiveAdmin.register CommunityManager do
  menu parent: 'Users'

  form do |f|
    f.inputs do
      # collection_select(:user, :user_id, User.all, :id, :username, {})
      # collection_select(:county, :count_id, County.all, :id, :name, {})
      f.input :user, as: :select, collection: User.all.map{|u| [u.username, u.id]}
      f.input :county, as: :select, collection: County.all.map{|c| [c.name, c.id]}
      f.input :discipline, as: :select, collection: Discipline.all.map{|d| [d.name, d.id]}
      f.input :mission
    end
    f.buttons
  end

end
