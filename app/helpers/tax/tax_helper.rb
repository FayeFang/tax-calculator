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
  def head_to_heads(team1, team2)
    away_team = team1
    home_team = team2

    home_team_hash = Hash.new(0)
    away_team_hash = Hash.new(0)
    count = 0
    CSV.open("#{Rails.root}/public/info.csv").each_with_index do |row, index|
      next if index < 2
      # home_team_hash[row[3]]+= 1
      # away_team_hash[row[5]]+= 1
      # puts "visiting team: #{row[3]}"
      # puts "home team: #{row[5]}"
      if (row[3] == away_team && row[5] == home_team) || (row[3] == home_team && row[5] == away_team)
        count += 1
        puts "#{row[3]}@#{row[5]}"
      end
    end

    puts "count: #{count}"
  end

  # head_to_heads('Toronto Raptors', 'Brooklyn Nets')
  # puts "*" * 20
  # head_to_heads('Detroit Pistons', 'Atlanta Hawks')

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
    puts h.inspect
    h
  end

  def get_percentage_for(team)
    final_array = []
    days_in_season = 199.0
    schedule_hash = away_schedules(team)
    p schedule_hash
    schedule_hash.each do |key, value|
      pct = (value / days_in_season).to_f
      # puts "#{team} in #{key}, pct: #{pct}"
      # puts "#{key}, #{value}, #{pct}"
      final_array << [key, value, pct]
      # puts "*" * 20
    end
    puts "final_array: #{final_array.inspect}"
  end

  #   teams = get_teams
  # puts "teams count: #{teams.count}"
  # p teams.combination(2).to_a.count
  #  teams.combination(2).to_a.each do |teams|
  #  	puts teams.inspect
  # 	head_to_heads(teams[0], teams[1])
  #  end

  #     puts "#" * 25

  #     teams.each do |team|
  #     	puts "Away Schedules for #{team}"
  #     	away_schedules(team)
  #     	puts "*" * 20
  #     	get_percentage_for(team)
  # end
end
