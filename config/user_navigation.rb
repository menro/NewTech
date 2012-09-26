# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'active'

  navigation.items do |primary|
    if user_signed_in?
      if current_user.is_admin?
        primary.item :admin, content_tag(:i, nil, :class => 'icon-cogs') << t(:'simple_navigation.admin'), admin_dashboard_path
      end
      primary.item :account, current_user.username, "#" do |account|
        account.item :account_profile, content_tag(:i, nil, :class => 'icon-user icon-large') << t(:'simple_navigation.account.profile'),
                     profile_path

        account.item :companies, content_tag(:i, nil, :class => 'icon-folder-open icon-large') << t(:'simple_navigation.account.companies'),
                     companies_path

        account.item :account_logout, content_tag(:i, nil, :class => 'icon-off') << t(:'simple_navigation.account.logout'),
                     destroy_user_session_path, :method => 'delete'
      end

    end
    primary.dom_class = 'nav'
  end

end
