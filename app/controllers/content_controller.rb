class ContentController < ApplicationController
  include Tax::TaxHelper

  def lookup
    @teams = get_teams
  end

  def summary
    @lookup_hash = lookup_hash
    @team1_tax = calculate_tax(@lookup_hash[:team1], @lookup_hash[:filter], @lookup_hash[:income])
    @team2_tax = calculate_tax(@lookup_hash[:team2], @lookup_hash[:filter], @lookup_hash[:income])
    @winner = @team1_tax[:net_income] > @team2_tax[:net_income] ? @team1_tax : @team2_tax
    @loser = @team1_tax[:net_income] > @team2_tax[:net_income] ? @team2_tax : @team1_tax
  end

  private def lookup_hash
    @lookup_hash = params.permit(:contract, :years, :filter, :team1, :team2)
  end
end
