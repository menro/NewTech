namespace :system do

  desc "Install system with default preferences"
  task :bootstrap => :environment do |t|
    puts "Initialize system..."
    puts "Done"
  end

end
