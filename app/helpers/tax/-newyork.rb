
def newyork(income, status, _pct)
  # Gross Income.
  # income = 1000000
  # Filing Status.
  @status = 'single' # Potential Options : case SINGLE: MARRIED_FILLING_SEPARATELY : HEAD_OF_HOUSEHOLD : MARRIED_FILLING_JOINTLY : WIDOW

  # Based on filing status select thresholds
  case status
  when 'single', 'married_filing_seperately'
    std_ded = 7900.0
  when /p\s+(\w+)/
    dumpVariable(Regexp.last_match(1))
  when 'head_of_household'
    std_ded = 11_100.0
  when 'married', 'widow'
    std_ded = 15_850.0
  else
    print 'Illegal command'
  end

  agi = income - std_ded

  taxable_income = agi
  #
  # tax = 51173.69 + 0.123 * (income - 526443.00)
  #       ^Taxes paid in previous brackets
  #                    ^ Tax Rate
  #                            ^ Income
  #                                       ^ Income already taxed in previous brackets
  if status == 'single'
    tax = if taxable_income < 8400.00
            0.04 * taxable_income
          elsif taxable_income <  11_600.00
            336 +  0.045 * (taxable_income -   8400.00)
          elsif taxable_income <  13_750.00
            816 +  0.0525 * (taxable_income -  11_600.00)
          elsif taxable_income <  21_150.00
            1073 +  0.059 * (taxable_income -  13_750.00)
          elsif taxable_income <  79_600.00
            1622 +  0.0645 * (taxable_income - 21_150.00)
          elsif taxable_income <  212_500.00
            0.0665 * (taxable_income - 79_600.00)
          elsif taxable_income <  1_062_650.00
            0.0685 * taxable_income
          else
            0.0882 * taxable_income
          end
  end

  if status == 'married'
    if taxable_income < 16_950.00
      tax = 0.04 * taxable_income
    elsif taxable_income <  23_300.00
      tax = 678 + 0.045 * (taxable_income - 8400.00)
    elsif taxable_income <  27_550
          .tax = 1642 + 0.0525 * (taxable_income - 11_600.00)
    elsif taxable_income <  42_450
      tax =   2151 +  0.059 * (taxable_income - 13_750.00)
    elsif taxable_income <  159_350
      tax =   3253 +  0.0645 * (taxable_income - 21_150.00)
    elsif taxable_income <  318_750.00
      tax = 0.0665 * taxable_income
    elsif taxable_income <  2_125_450
      tax = 29_812 + 0.0685 * (taxable_income - 212_500.00)
    else
      tax = 0.0882 * taxable_income
    end
  end

  # Itemized Deductions.
  # if taxable_income > threshA
  # income from other states?
  # end

  # Calculate taxes.
  net = income - tax
  puts '--- New York ---'
  printf "Net: %s Tax: %-20s\n", net, tax
end
