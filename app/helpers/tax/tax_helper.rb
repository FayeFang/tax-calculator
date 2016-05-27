load 'tax/-california.rb'
load 'tax/arizona.rb'
load 'tax/-colorado.rb'
load 'tax/-florida.rb'
load 'tax/georgia.rb'
load 'tax/-michigan.rb'
load 'tax/-illinois.rb'
load 'tax/-northcarolina.rb'
load 'tax/-pennsylvania.rb'
load 'tax/-utah.rb'
load 'tax/-wisconsin.rb'
load 'tax/-newyork.rb'
load 'tax/-massachusetts.rb'
load 'tax/-dc.rb'
load 'tax/texas.rb'
load 'tax/oklahoma.rb'
load 'tax/philedelphia.rb'
load 'tax/indiana.rb'
load 'tax/oregon.rb'
load 'tax/minnesota.rb'
load 'tax/tennesee.rb'
load 'tax/louisiana.rb'
load 'tax/ontario.rb'

require 'rubygems'
require 'csv'

module Tax::TaxHelper
  def get_teams
    teams_array = []
    months_array = %w(January February March April May June July August September October November December)

    CSV.open("#{Rails.root}/public/info.csv").each_with_index do |row, index|
      next if index < 2
      next if months_array.include? row[3]
      next if months_array.include? row[5]

      teams_array << row[3]
      teams_array << row[5]
    end
    teams_array.uniq.sort
  end

  def away_schedules(team)
    h = Hash.new(0)
    CSV.open("#{Rails.root}/public/info.csv").each_with_index do |row, index|
      next if index < 2
      next unless row[3] == team # team is an away team
      # count += 1
      h[row[3]] += 1
      h[row[5]] += 1
      # puts "#{row[3]}@#{row[5]}"
    end
    h
    # puts h.inspect
  end

  def get_percentage_for(team)
    final_array = []
    days_in_season = 199.0
    schedule_hash = away_schedules(team)
    # p schedule_hash
    schedule_hash.each do |key, value|
      pct = if key == team
              1
            else
              (value / days_in_season).to_f
            end
      # puts "#{team} in #{key}, pct: #{pct}"
      # puts "#{key}, #{value}, #{pct}"
      final_array << [key, value, pct]
      # puts "*" * 20
    end
    # puts "final_array: #{final_array.inspect}"
    final_array
  end

  # teams = get_teams
  # teams.each do |team|
  #   # puts "Away Schedules for #{team}"
  #   away_schedules(team)
  #   # puts "*" * 20
  #   get_percentage_for(team)
  # end

  LOCATION_HASH = { 'Toronto Raptors' => %w(Toronto ON CA),
                    'Miami Heat' => %w(Miami FL US),
                    'Dallas Mavericks' => %w(Dallas TX US),
                    'Orlando Magic' => %w(Orlando FL US),
                    'San Antonio Spurs' => ['San Antonio', 'TX', 'US'],
                    'Indiana Pacers' => %w(Indianapolis IN US),
                    'Brooklyn Nets' => %w(Brooklyn NY US),
                    'Milwaukee Bucks' => %w(Milwaukee WI US),
                    'Oklahoma City Thunder' => ['Oklahoma City', 'OK', 'US'],
                    'Memphis Grizzlies' => %w(Memphis TN US),
                    'Sacramento Kings' => %w(Sacramento CA US),
                    'New York Knicks' => ['New York City', 'NY', 'US'],
                    'Portland Trail Blazers' => %w(Portland OR US),
                    'Golden State Warriors' => %w(Oakland CA US),
                    'Denver Nuggets' => %w(Denver CO US),
                    'Atlanta Hawks' => %w(Atlanta GA US),
                    'Cleveland Cavaliers' => %w(Cleveland OH US),
                    'New Orleans Pelicans' => ['New Orleans', 'LA', 'US'],
                    'Los Angeles Clippers' => ['Los Angeles', 'CA', 'US'],
                    'Phoenix Suns' => %w(Phoenix AZ US),
                    'Minnesota Timberwolves' => %w(Minneapolis MN US),
                    'Boston Celtics' => %w(Boston MA US),
                    'Detroit Pistons' => %w(Detroit MI US),
                    'Charlotte Hornets' => %w(Charlotte NC US),
                    'Houston Rockets' => %w(Houston TX US),
                    'Chicago Bulls' => %w(Chicago IL US),
                    'Washington Wizards' => %w(Washington DC US),
                    'Utah Jazz' => ['Salt Lake City', 'UT', 'US'],
                    'Philadelphia 76ers' => %w(Philadelphia PA US),
                    'Los Angeles Lakers' => ['Los Angeles', 'CA', 'US'] }.freeze

  def get_country(team)
    LOCATION_HASH[team][2]
  end

  def get_state(team)
    LOCATION_HASH[team][1]
  end

  def get_city(team)
    LOCATION_HASH[team][0]
  end

  # for testing
  # TO BE REMOVED LATER
  def calculate_tax(team_name, _status, _income)
    if team_name == 'Atlanta Hawks'
      {
        team_name: team_name,
        total_income: 1_000_000,
        federal_tax: 40_000_000,
        state_tax: 500_000,
        city_tax: 55_000,
        social_security: 30_000,
        fica: 10_000,
        net_income: 5_405_000
      }
    else
      {
        team_name: team_name,
        total_income: 1_000_000,
        federal_tax: 30_000_000,
        state_tax: 500_000,
        city_tax: 55_000,
        social_security: 30_000,
        fica: 10_000,
        net_income: 6_405_000
      }
    end
  end

  # def calculate_tax(team_name, status, income)
  #   city = get_city(team_name)
  #   state = get_state(team_name)
  #   country = get_country(team_name)

  #   team_with_pcts = get_percentage_for(team_name)
  #   team_with_pcts.each do |a|
  #     puts "\n"
  #     puts "*" * 20
  #      a.inspect
  #     team = a[0]
  #     pct = a[2]
  #     city = get_city(team)
  #     state = get_state(team)
  #     country = get_country(team)

  #     if state == 'ON'
  #       ontario(income, status, pct)
  #     end
  #     if state == 'WI'
  #       wisconsin(income, status, pct)
  #     end
  #     if state == 'GA'
  #       georgia(income, status, pct)
  #     end
  #     if state == 'IL'
  #       illinois(income, status, pct)
  #     end
  #     if state == 'AZ'
  #       arizona(income, status, pct)
  #     end
  #     if state == 'CA'
  #       california(income, status, pct)
  #     end
  #     if state == 'NY'
  #       newyork(income, status, pct)
  #     end
  #     if city = 'Philedelphia' && state == 'PA'
  #       pennsylvania(income, status, pct)
  #       philedelphia(income, status, pct)
  #     end
  #     if city == 'Cinncinati' && state == 'OH'
  #       ohio(income, status, pct)
  #     end
  #     if city == 'Cleveland' && state == 'OH'
  #       ohio(income, status, pct)
  #       cleveland(income, status, pct)
  #     end
  #     if state == 'CO'
  #       colorado(income, status, pct)
  #     end
  #     if state == 'MN'
  #       minnesota(income, status, pct)
  #     end
  #     if state == 'MI'
  #       michigan(income, status, pct)
  #     end
  #     if state == 'LA'
  #       louisiana(income, status, pct)
  #     end
  #     if state == 'FL'
  #       florida(income, status, pct)
  #     end
  #     if state == 'TN'
  #       tennesee(income, status, pct)
  #     end
  #     if state == 'NC'
  #       northcarolina(income, status, pct)
  #     end
  #     if state == 'ONT'
  #       ontario(income, status, pct)
  #     end
  #     if state == 'DC'
  #       dc(income, status, pct)
  #     end
  #     if state == 'TX'
  #       texas(income, status, pct)
  #     end
  #     if state == 'IN'
  #       indiana(income, status, pct)
  #     end
  #     if state == 'OR'
  #       oregon(income, status, pct)
  #     end
  #     if state == 'UT'
  #       utah(income, status, pct)
  #     end
  #     if state == 'OK'
  #       oklahoma(income, status, pct)
  #     end
  #     if state == 'MA'
  #       massachusetts(income, status, pct)
  #     end
  #   end
  # end
end
