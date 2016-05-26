def northcarolina(income, status, _pct)
  case status
  when 'single'
    std_ded = 7500
  when /p\s+(\w+)/
    dumpVariable(Regexp.last_match(1))
  when 'married_filing_seperately'
    std_ded = 7500
  when 'head_of_household'
    std_ded = 15_000
  when 'married', 'widow'
    std_ded = 15_000
  else
    print 'Illegal command'
  end

  agi = income
  taxable_income = agi - std_ded
  tax = 0.0575
  tax = taxable_income * tax

  # Calculate taxes.
  net = income - tax
  puts '--- North Carolina ---'
  printf "Net: %s Tax: %-20s\n", net, tax
end
