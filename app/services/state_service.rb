class StateService
  def self.all
    states = State.all
    StateDecorator::decorate(states)
  end

  def self.search(params)
    params[:country_name] ||= "United States"
    states = State.where(country_id: Country.where(name: params[:country_name]).first.id).scoped
    states = states.with_companies_name_like params[:company_name] unless params[:company_name].blank?
    states = states.with_companies_founded_from params[:from_year] unless params[:from_year].blank?
    states = states.with_companies_founded_to params[:to_year] unless params[:to_year].blank?
    states = states.with_company_tagged_as params[:tag_code] unless params[:tag_code].blank?
    states = states.with_company_are_hiring unless params[:hiring].blank?
    states = states.with_company_employee_type(params[:employee_id]) unless params[:employee_id].blank?
    states = states.with_company_investment_type(params[:investment_id]) unless params[:investment_id].blank?
    states = states.with_company_category(params[:category_id]) unless params[:category_id].blank?
    states = StateDecorator.decorate(states.uniq, :search_params => params)
    states = states.sort_by(&:companies_numbers).reverse
  end

  def self.colorado_state
    State.where(name: 'Colorado').map{|s| [s.name, s.id]}
  end

  def self.states_as_options
    State.select("name, id")
  end

end