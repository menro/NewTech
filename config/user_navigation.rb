# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'active'

  navigation.items do |primary|
    if user_signed_in?
      primary.item :account, current_user.username, "#" do |account|
        account.item :account_profile, content_tag(:i, nil, :class => 'icon-user icon-large') << t(:'simple_navigation.account.profile'),
                     "#"

        account.item :account_logout, content_tag(:i, nil, :class => 'icon-off') << t(:'simple_navigation.account.logout'),
                     destroy_user_session_path, :method => 'delete'
      end
    end
    primary.dom_class = 'nav'
  end

end
