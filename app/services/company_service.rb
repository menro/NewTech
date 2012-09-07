class CompanyService

  def self.new_company
    Company.new
  end

  def self.create company
    return Company.create do |c|
      c.name = company[:name]
    end
  end

end
