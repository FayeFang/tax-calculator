
def colorado(income, _status, _pct)
  # INIT VARIABLES
  if homestate = 'Colorado' || 'CO'
    resident = true
  end

  # The colorado tax uses the federal income
  agi = income - 6300
  taxable_income = agi
  tax_rate = 0.0463

  # Calculate taxes.
  tax = (taxable_income * tax_rate)
  net = taxable_income - tax

  puts '--- Colorado ---'
  printf "Net: %s Tax: %-20s\n", net, tax
end
