class ContentController < ApplicationController
  include Tax::TaxHelper

  def lookup
    @teams = get_teams
  end

  def summary
    head_to_heads(lookup_hash[:team1], lookup_hash[:team2])
  end

  private def lookup_hash
    @lookup_hash = params.permit(:contract, :years, :filter, :team1, :team2)
  end
end
