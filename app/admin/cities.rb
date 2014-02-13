ActiveAdmin.register City  do

  form do |f|
    f.inputs do
      f.input :name
      # collection_select(:user, :user_id, User.all, :id, :username, {})
      f.input :county, as: :select, collection: County.order('name ASC').all.map{|c| [c.name, c.id]}
      f.input :longitude
      f.input :latitude
    end
    f.buttons
  end

end
