# -*- coding: utf-8 -*-
# Configures your navigation

SimpleNavigation::Configuration.run do |navigation|

  navigation.selected_class = 'active'

  navigation.items do |primary|

    primary.dom_class = 'nav pull-right'

    primary.item :add_a_job, content_tag(:i, nil, :class => 'icon-plus') << t(:'simple_navigation.post_a_job'), new_job_url
    primary.item :add_you_company, content_tag(:i, nil, :class => 'icon-plus') << t(:'simple_navigation.add_you_company'), new_company_url
    if user_signed_in?
      primary.item :account, content_tag(:i, nil, :class => 'icon-user') << current_user.username, "#" do |account|
        account.item  :account_profile,
                      content_tag(:i, nil, :class => 'icon-user icon-large') << t(:'simple_navigation.account.profile'),
                      profile_path

        account.item  :companies,
                      content_tag(:i, nil, :class => 'icon-folder-open icon-large') << t(:'simple_navigation.account.companies'),
                      companies_path

        account.item  :jobs,
                      content_tag(:i, nil, :class => 'icon-briefcase icon-large') << t(:'simple_navigation.account.jobs'),
                      jobs_path

        if current_user.is_admin?
          account.item :admin, content_tag(:i, nil, :class => 'icon-cogs') << t(:'simple_navigation.admin'), admin_dashboard_path
        end

        account.item :account_logout, content_tag(:i, nil, :class => 'icon-off') << t(:'simple_navigation.account.logout'),
                     destroy_user_session_path, :method => 'delete'
      end

    else
      primary.item :sign_in, t(:'simple_navigation.login'), new_user_session_url
    end

  end

end
