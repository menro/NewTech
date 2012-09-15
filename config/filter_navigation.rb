# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'active'

  navigation.items do |primary|
    primary.item :employee, "Jobs", "#"
    primary.item :employee, "Employee", "#" do |employee|
      employee.item :one, "<10", "#"
      employee.item :one, "11 - 25", "#"
      employee.item :one, "26 - 75", "#"
      employee.item :one, "76 . 250", "#"
      employee.item :one, "> 250", "#"
    end
    primary.item :employee, "Investment", "#" do |employee|
      employee.item :one, "<10", "#"
      employee.item :one, "11 - 25", "#"
      employee.item :one, "26 - 75", "#"
      employee.item :one, "76 . 250", "#"
      employee.item :one, "> 250", "#"
    end
    primary.dom_class = 'nav dropup'
  end

end
