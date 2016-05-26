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

    CSV.open('info.csv').each_with_index do |row, index|
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
    CSV.open('info.csv').each_with_index do |row, index|
      next if index < 2
      if row[3] == team # team is an away team
        # count += 1
        h[row[3]] += 1
        h[row[5]] += 1
        # puts "#{row[3]}@#{row[5]}"
      end
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
      if key == team
        pct = 1
      else
        pct = (value / days_in_season).to_f
      end
      # puts "#{team} in #{key}, pct: #{pct}"
      # puts "#{key}, #{value}, #{pct}"
      final_array << [key, value, pct]
      # puts "*" * 20
    end
    # puts "final_array: #{final_array.inspect}"
    final_array
  end

  teams = get_teams
  teams.each do |team|
    # puts "Away Schedules for #{team}"
    away_schedules(team)
    # puts "*" * 20
    get_percentage_for(team)
  end

  LOCATION_HASH = {'Toronto Raptors' => [ 'Toronto','ON','CA'],
                  'Miami Heat' => [ 'Miami','FL','US'],
                  'Dallas Mavericks' => [ 'Dallas','TX','US'],
                  'Orlando Magic' => [ 'Orlando','FL','US'],
                  'San Antonio Spurs' => [ 'San Antonio','TX','US'],
                  'Indiana Pacers' => [ 'Indianapolis','IN','US'],
                  'Brooklyn Nets' => [ 'Brooklyn','NY','US'],
                  'Milwaukee Bucks' => [ 'Milwaukee','WI','US'],
                  'Oklahoma City Thunder' => [ 'Oklahoma City','OK','US'],
                  'Memphis Grizzlies' => [ 'Memphis','TN','US'],
                  'Sacramento Kings' => [ 'Sacramento','CA','US'],
                  'New York Knicks' => [ 'New York City','NY','US'],
                  'Portland Trail Blazers' => [ 'Portland','OR','US'],
                  'Golden State Warriors' => [ 'Oakland','CA','US'],
                  'Denver Nuggets' => [ 'Denver','CO','US'],
                  'Atlanta Hawks' => [ 'Atlanta','GA','US'],
                  'Cleveland Cavaliers' => [ 'Cleveland','OH','US'],
                  'New Orleans Pelicans' => [ 'New Orleans','LA','US'],
                  'Los Angeles Clippers' => [ 'Los Angeles','CA','US'],
                  'Phoenix Suns' => [ 'Phoenix','AZ','US'],
                  'Minnesota Timberwolves' => [ 'Minneapolis','MN','US'],
                  'Boston Celtics' => [ 'Boston','MA','US'],
                  'Detroit Pistons' => [ 'Detroit','MI','US'],
                  'Charlotte Hornets' => [ 'Charlotte','NC','US'],
                  'Houston Rockets' => [ 'Houston','TX','US'],
                  'Chicago Bulls' => [ 'Chicago','IL','US'],
                  'Washington Wizards' => [ 'Washington','DC','US'],
                  'Utah Jazz' => [ 'Salt Lake City','UT','US'],
                  'Philadelphia 76ers' => [ 'Philadelphia','PA','US'],
                  'Los Angeles Lakers' => [ 'Los Angeles','CA','US'],}

  def get_country(team)
    LOCATION_HASH[team][2]
  end

  def get_state(team)
    LOCATION_HASH[team][1]
  end

  def get_city(team)
    LOCATION_HASH[team][0]
  end

  def calculate_tax(team_name, status, income)
    city = get_city(team_name)
    state = get_state(team_name)
    country = get_country(team_name)

    team_with_pcts = get_percentage_for(team_name)
    team_with_pcts.each do |a|
      puts "\n"
      puts "*" * 20
       a.inspect
      team = a[0]
      pct = a[2]
      city = get_city(team)
      state = get_state(team)
      country = get_country(team)
      
      if state == 'ON'
        ontario(income, status, pct)
      end
      if state == 'WI'
        wisconsin(income, status, pct)
      end
      if state == 'GA'
        georgia(income, status, pct)
      end
      if state == 'IL'
        illinois(income, status, pct)
      end
      if state == 'AZ'
        arizona(income, status, pct)
      end
      if state == 'CA'
        california(income, status, pct)
      end
      if state == 'NY'
        newyork(income, status, pct)
      end
      if city = 'Philedelphia' && state == 'PA'
        pennsylvania(income, status, pct)
        philedelphia(income, status, pct)
      end
      if city == 'Cinncinati' && state == 'OH'
        ohio(income, status, pct)
      end
      if city == 'Cleveland' && state == 'OH'
        ohio(income, status, pct)
        cleveland(income, status, pct)
      end
      if state == 'CO'
        colorado(income, status, pct)
      end
      if state == 'MN'
        minnesota(income, status, pct)
      end
      if state == 'MI'
        michigan(income, status, pct)
      end
      if state == 'LA'
        louisiana(income, status, pct)
      end
      if state == 'FL'
        florida(income, status, pct)
      end
      if state == 'TN'
        tennesee(income, status, pct)
      end
      if state == 'NC'
        northcarolina(income, status, pct)
      end
      if state == 'ONT'
        ontario(income, status, pct)
      end
      if state == 'DC'
        dc(income, status, pct)
      end
      if state == 'TX'
        texas(income, status, pct)
      end
      if state == 'IN'
        indiana(income, status, pct)
      end
      if state == 'OR'
        oregon(income, status, pct)
      end
      if state == 'UT'
        utah(income, status, pct)
      end
      if state == 'OK'
        oklahoma(income, status, pct)
      end
          if state == 'MA'
        massachusetts(income, status, pct)
      end
    end
  end
end
