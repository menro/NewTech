module HomeHelper

  def search_params_data
    {
        :company_name => "",
        :from_year => "",
        :to_year => "",
        :tag_code => "",
        :current_county_id => "",
        :hiring => "",
        :employee_id => "",
        :investment_id => "",
        :category_id => ""
    }
  end

  def gmap_data
    {
        :offices_url => "#{companies_api_v1_url(:json)}",
        :counties_url => "#{counties_api_v1_url(:json)}",
        :county_url => "#{county_api_v1_url(:json)}",
        :tags_url => "#{tags_api_v1_url(:json)}",
        :employees_types_url => "#{employees_types_api_v1_url(:json)}",
        :investments_types_url => "#{investments_types_api_v1_url(:json)}",
        :categories_url => "#{categories_api_v1_url(:json)}"
    }
  end
end
