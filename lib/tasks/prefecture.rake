require 'csv'

namespace :prefecture do
  desc "東京都と、市区町村の初期化"
  task :import_tokyo_cities => :environment do
    puts 'Start create tokyo and cities...'
    prefecture = Prefecture.find_or_create_by(name: '東京都')

    open("./lib/tasks/csv/tokyo_cities.csv", "rb:Shift_JIS:UTF-8", undef: :replace) do |f|
      CSV.new(f).each_with_index do |row, i|
        next if i == 0
        prefecture.cities.find_or_create_by(name: row)
      end
    end
    puts "Created Prefecture: #{Prefecture.count}, City: #{City.count}"
  end
end
