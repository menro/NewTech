# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'active'

  navigation.items do |primary|
    primary.item :jobs, t(:'simple_navigation.jobs'), "#"
    primary.item :register_to_attend, t(:'simple_navigation.register_to_attend'), "#"
    primary.item :present, t(:'simple_navigation.present'), "#"
    primary.item :add_you_company, t(:'simple_navigation.add_you_company'), new_company_url
    primary.dom_class = 'nav'
  end

end
