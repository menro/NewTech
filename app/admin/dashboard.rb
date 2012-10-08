ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do

    section "Recent Companies", :priority => 1 do
      table_for Company.order("created_at desc").limit(10) do
        column :created_at
        column "Owner", :user
        column :name
      end
      strong { link_to "View All Companies", admin_companies_path }
    end

    section "Recent Users", :priority => 4 do
      table_for User.order("created_at desc").limit(10) do
        column :created_at
        column("Name")    {|user| link_to user.name, [:admin, user] }
        column :email
      end
      strong { link_to "View All Users", admin_users_path }
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
