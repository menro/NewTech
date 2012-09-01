namespace :system do

  desc "Install system with default preferences"
  task :bootstrap => :environment do |t|
    puts "Initialize system..."
    Rake::Task["db:migrate"].invoke
    Rake::Task["db:seed"].invoke
    puts "Done"
  end


  desc "Import colorado's companies from crunchbase"
  task :import_crunchbase_companies => :environment do |t|
    puts "Import companies..."
    companies = []
    client = HTTPClient.new
    response = client.get "http://api.crunchbase.com/v/1/search.js", {
        :geo => "Denver"
    }
    status = response.header.status_code
    unless status == 404 || status == 500
      json = JSON.parse( response.body )
      companies += json['results']
    end

    companies.each do |company|
      company.delete("namespace")
      company.delete("image")
      company.delete("crunchbase_url")
      company['offices_attributes'] = company.delete("offices")
      Company.create company
      puts "Created company: #{company['name']}"
    end
    puts "Done"
  end

end
