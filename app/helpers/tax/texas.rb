def texas(income, _status, _pct)
  # Calculate taxes.
  tax = 0
  net = income - tax
  puts '--- Texas ---'
  printf "Net: %s Tax: %-20s\n", net, tax
end
