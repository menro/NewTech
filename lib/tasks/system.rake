require 'httpclient'

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
    client = HTTPClient.new
    response = client.get "http://api.crunchbase.com/v/1/search.js", {
        :geo => "Denver"
    }

    puts response.body
  end

end
