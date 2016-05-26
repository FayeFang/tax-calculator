
def massachusetts(income, status, _pct)
  case status
  when 'single'
    std_exmp = 4400.0
    std_ded = 2000
  when /p\s+(\w+)/
    dumpVariable(Regexp.last_match(1))
  when 'married_filing_seperately'
    std_exmp = 4400.0
    std_ded = 2000
  when 'head_of_household'
    std_exmp = 4400.0
    std_ded = 2000
  when 'married', 'widow'
    std_exmp = 8800.0
    std_ded = 2000
  else
    print 'Illegal command'
  end

  agi = income
  taxable_income = agi - std_exmp - std_ded

  # Calculate taxes.
  tax = taxable_income * 0.0515

  # net income
  net = income - tax
  puts '--- Massachusetts ---'
  printf "Net: %s Tax: %-20s\n", net, tax
end
