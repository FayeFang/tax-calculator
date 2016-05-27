class ContentController < ApplicationController
  include Tax::TaxHelper

  def lookup
    @teams = get_teams
  end

  def summary
    @lookup_hash = lookup_hash
  end

  private def lookup_hash
    @lookup_hash = params.permit(:contract, :years, :filter, :team1, :team2)
  end
end
