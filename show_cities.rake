namespace :show do
  desc "Show cities in US"
  task :cities => :environment do
    Cities.data_path = "lib/tasks/cities"
    puts Cities.data_path
    cities = Cities.cities_in_country('US')
    puts cities
   end
end