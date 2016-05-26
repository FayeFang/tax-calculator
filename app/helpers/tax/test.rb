require './tax_helper.rb'

class Test
  include ::TaxHelper
end

t = Test.new

puts t.get_teams
