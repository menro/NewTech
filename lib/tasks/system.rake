namespace :system do

  desc "Install system with default preferences"
  task :bootstrap => :environment do |t|
    puts "Initialize system..."
    Rake::Task["db:migrate"].invoke
    Rake::Task["db:seed"].invoke
    puts "Done"
  end

end
