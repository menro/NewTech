object false

child @freelancers => :freelancers do
attributes  :id

node(:show_freelancer_users_url) { |user| show_freelancer_users_url(user.username) }
node(:freelancer_avatar_thumb_url) { |user| user.avatar.url(:thumb_large) }
node(:freelancer_discipline_name) { |user| user.discipline.name.slice(0,9) }
end

child @jobs => :jobs do
attributes  :id, :clickthrough, :email, :company_name

node(:title) { |job| ((job.title.length > 30) ? (job.title.slice(0, 30) + "...") : job.title) }
end

child @events => :events do
attributes :id, :preview, :title

node(:start_at) { |event| event.start_at.to_time.strftime("%B %e %l.%M%p") }

end

child @companies => :companies do
attributes :id

node(:img_url) { |company| company.image.url(:thumb_small) }
node(:category_name) { |company| company.category.name }

end