
def arizona(income, status, _pct)
  case status
  when 'single'
    std_ded = 5091.0
    std_exmp = 2100
  when /p\s+(\w+)/
    dumpVariable(Regexp.last_match(1))

  when 'married_filing_seperately'
    std_ded = 5091.0
    std_exmp = 2100
  when 'head_of_household'
    std_ded = 10_173.0
    std_exmp = 4200
  when 'married'
    std_ded = 10_173.0
    std_exmp = 4200
  else
    print 'Illegal command'
  end

  # TAX ROUTINE
  # Calculate Adjusted Gross Income
  agi = income

  taxable_income = agi - std_ded

  #
  # tax = 51173.69 + 0.123 * (income - 526443.00)
  #       ^Taxes paid in previous brackets
  #                    ^ Tax Rate
  #                            ^ Income
  #                                       ^ Income already taxed in previous brackets

  if status == 'single'
    tax = if taxable_income < 10_163.00
            0.0259 * taxable_income
          elsif taxable_income <  25_406.00
            263.2217 +  0.0288 * (taxable_income - 10_163.00)
          elsif taxable_income <  50_812.00
            438.9984 +  0.0336 * (taxable_income -  25_406.00)
          elsif taxable_income <  152_434.00
            853.6416 +  0.0424 * (taxable_income -  50_812.00)
          else
            0.0454 * (taxable_income - 1056)
          end
  end

  if status == 'married'
    tax = if taxable_income < 15_700.00
            0.01 * taxable_income
          elsif taxable_income <   37_220.00
            157.00 +  0.02 * (taxable_income -  15_700.00)
          elsif taxable_income <   58_744.00
            587.40 +  0.04 * (taxable_income -  37_220.00)
          elsif taxable_income <   81_546.00
            1448.36 +  0.06 * (taxable_income -  58_744.00)
          elsif taxable_income <  103_060.00
            2816.48 +  0.08 * (taxable_income -  81_546.00)
          elsif taxable_income <  526_444.00
            4537.60 + 0.093 * (taxable_income - 103_060.00)
          elsif taxable_income <  631_732.0
            43_912.31 + 0.103 * (taxable_income - 526_444.00)
          elsif taxable_income < 1_052_886.00
            54_756.97 + 0.113 * (taxable_income - 631_732.00)
          else
            109_347.37 + 0.133 * (taxable_income - 1_052_886.00)
          end
  end

  # Calculate taxes.
  net = taxable_income - tax
  puts '--- Arizona ---'
  printf "Net: %s Tax: %-20s\n", net, tax
end
