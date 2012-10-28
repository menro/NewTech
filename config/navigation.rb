# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'active'

  navigation.items do |primary|
    primary.item :present, t(:'simple_navigation.present'), "#"
    primary.item :message_board, t(:'simple_navigation.message_board'), "#"
    primary.item :jobs_board, t(:'simple_navigation.jobs'), "#"
    primary.item :blogs, t(:'simple_navigation.blogs'), "#"
    primary.dom_class = 'nav'
  end

end
