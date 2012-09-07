class CompanyService

  def self.new_company
    company = Company.new
    company.offices.build
    CompanyDecorator.new(company)
  end

  def self.create company
    tags_list = company.delete("tags_list")
    CompanyDecorator.create company do |c|
      ( tags_list.split(",") rescue [] ).each do |tag|
        c.tags << Tag.find_or_create_by_code(tag.strip)
      end
    end
  end

end
