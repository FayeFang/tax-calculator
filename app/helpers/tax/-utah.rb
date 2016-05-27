def utah(income, _status, _pct)
  taxable_income = income
  tax_rate = 0.0500
  # Calculate taxes.
  tax = taxable_income * tax_rate

  # net income
  net = income - tax
  puts '--- Utah ---'
  printf "Net: %s Tax: %-20s\n", net, tax
end
