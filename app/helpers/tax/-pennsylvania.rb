def pennsylvania(income, _status, _pct)
  agi = income
  tax = 0.0307
  tax = agi * tax

  # Calculate taxes.
  net = income - tax
  puts '--- Pennsylvania ---'
  printf "Net: %s Tax: %-20s\n", net, tax
end
