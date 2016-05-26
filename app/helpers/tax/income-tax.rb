load '-california.rb'
load 'arizona.rb'
load '-colorado.rb'
load '-florida.rb'
load 'georgia.rb'
load '-michigan.rb'
load '-illinois.rb'
load '-northcarolina.rb'
load '-pennsylvania.rb'
load '-utah.rb'
load '-wisconsin.rb'
load '-newyork.rb'
load '-massachusetts.rb'
load 'dc.rb'
load 'texas.rb'
load 'oklahoma.rb'

require 'csv'

schedule = CSV.read('schedule.csv')
CSV.foreach('schedule.csv') do |_row|
  # puts row.inspect
end

illinois(4_021_936, 'single', 'IL', 1)
arizona(4_021_936, 'single', 'AZ', 1)
colorado(4_021_936, 'single', 'CO', 1)
northcarolina(4_021_936, 'single', 'NC', 1)
pennsylvania(4_021_936, 'single', 'PA', 1)
utah(4_021_936, 'single', 'UT', 1)
wisconsin(4_021_936, 'single', 'UT', 1)
newyork(4_021_936, 'single', 'NY', 'NYC', 1)
massachusetts(4_021_936, 'single', 'MA', 1)
dc(4_021_936, 'single', 'DC', 1)
