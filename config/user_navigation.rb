# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'active'

  navigation.items do |primary|
    if user_signed_in?
      primary.item :account, content_tag(:i, nil, :class => 'icon-edit icon-large'), "#"
    end
    primary.dom_class = 'nav'
  end

end
