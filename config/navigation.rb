# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'active'

  navigation.items do |primary|
    primary.item :home, t(:'simple_navigation.home'), root_path
    primary.dom_class = 'nav'
  end

end
