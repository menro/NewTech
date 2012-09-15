# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'active'

  navigation.items do |primary|
    primary.item :jobs, "Jobs", "#"
    primary.item :employee, "Employee", "#" do |employee|
      employee.item :employee_one, "<10", "#"
      employee.item :employee_two, "11 - 25", "#"
      employee.item :employee_three, "26 - 75", "#"
      employee.item :employee_for, "76 . 250", "#"
      employee.item :employee_five, "> 250", "#"
    end
    primary.item :investment, "Investment", "#" do |investment|
      investment.item :investment_one, "<10", "#"
      investment.item :investment_two, "11 - 25", "#"
      investment.item :investment_three, "26 - 75", "#"
      investment.item :investment_for, "76 . 250", "#"
      investment.item :investment_five, "> 250", "#"
      investment.dom_class = 'dropup'
    end
    primary.dom_class = 'nav dropup'
  end

end
