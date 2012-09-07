namespace :system do

  desc "Install system with default preferences"
  task :bootstrap => :environment do |t|
    puts "Initialize system..."
    Rake::Task["db:migrate"].invoke
    Rake::Task["db:seed_fu"].invoke
    puts "Done"
  end


  desc "Import colorado's companies from crunchbase"
  task :import_crunchbase_companies => :environment do |t|
    puts "Import companies..."
    CrunchbaseService::import_companies_of_colorado
    puts "Done"
  end

end
