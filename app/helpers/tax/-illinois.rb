
def illinois(income, status, pct)
  case status
  when 'single'
    std_exmp = 2150.0
  when /p\s+(\w+)/
    dumpVariable(Regexp.last_match(1))
  when 'married_filing_seperately'
    std_exmp = 2150.0
  when 'head_of_household'
    std_exmp = 2150.0 * 2
  when 'married', 'widow'
    std_exmp = 2150.0 * 2
  else
    print 'Illegal command'
  end

  agi = income
  taxable_income = agi - std_exmp
  taxable_income * pct
  puts taxable_income
  tax = 0.0375
  # Calculate taxes.
  tax = taxable_income * 0.0375

  # net income
  net = income - tax
  puts '--- Illinois ---'
  printf "Net: %s Tax: %-20s\n", net, tax
end
