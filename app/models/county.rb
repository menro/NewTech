class County < ActiveRecord::Base
  has_many :cities

  has_many :offices, :through => :cities

  has_many :companies, :through => :offices

  attr_accessible :name, :zip, :state, :latitude, :longitude


  scope :with_companies_founded_from,
        lambda {|year|
          includes(:companies).where("`companies`.founded_year > ?", year)
        }

  scope :with_companies_founded_to,
        lambda {|year|
          includes(:companies).where("`companies`.founded_year < ?", year)
        }



  def offices_numbers
    offices.count
  end

  def offices_percentage
    ((offices_numbers * 100).to_f / Office.count.to_f).to_f
  end

end
