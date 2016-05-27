
def michigan(income, status, _pct)
  # if city == "Detroit"
  #     agi = income
  #     tax_rate = 0.0425
  #     tax = agi * tax_rate
  #     ctax_rate = 0.012
  #     city_tax = agi * ctax_rate

  #     tax = tax + city_tax
  # else

  agi = income
  tax_rate = 0.0425
  tax = agi * tax_rate
  # end

  case status
  when 'single'
    std_exmp = 4000
  when /p\s+(\w+)/
    dumpVariable(Regexp.last_match(1))
  when 'married_filing_seperately'
    std_exmp = 4000
  when 'head_of_household'
    std_exmp = 4000 * 2
  when 'married', 'widow'
    std_exmp = 4000 * 2
  else
    print 'Illegal command'
  end

  # Calculate taxes.
  net = income - tax
  puts '--- Michigan ---'
  printf "Net: %s Tax: %-20s\n", net, tax
end
