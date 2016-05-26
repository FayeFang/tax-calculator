
def minnesota(income, status, _pct)
  # Gross Income.
  # income = 1000000
  # Filing Status.
  # Resident?

  # Based on filing status select thresholds
  case status
  when 'single', 'married_filing_seperately'
    threshA = 178_706.0
    std_ded = 4044.0
  when /p\s+(\w+)/
    dumpVariable(Regexp.last_match(1))
  when 'head_of_household'
    threshA = 268_063.0
    std_ded = 8088.0
  when 'married', 'widow'
    threshA = 357_417.0
    std_ded = 8088.0
  else
    print 'Illegal command'
  end

  #
  # tax = 51173.69 + 0.123 * (income - 526443.00)
  #       ^Taxes paid in previous brackets
  #                    ^ Tax Rate
  #                            ^ Income
  #                                       ^ Income already taxed in previous brackets
  if status == 'single'
    tax = if income < 24_680.00
            0.0535 * income
          elsif income <  81_080.00
            1320.38 +  0.0705 * (income - 24_680.00)
          elsif income <  152_540.00
            5296.58 +  0.0785 * (income - 81_080.00)
          else
            10_906.19 + 0.0985 * (income - 152_540.00)
          end
  end

  if status == 'married'
    tax = if income < 36_080.00
            0.0535 * income
          elsif income <  143_350.00
            1930.28 +  0.0705 * (income - 36_080.00)
          elsif income <  254_240.00
            9492.82 +  0.0785 * (income - 143_350.00)
          else
            18_197.68 + 0.0985 * (income - 254_240.00)
          end
  end

  # # Standard Deductions.
  # if resident == false
  #     std_ded = pct * std_ded
  # else
  #     pct = 1
  #     std_ded = pct * std_ded
  # end

  tax -= std_ded

  # Itemized Deductions.
  # if income > threshA
  # income from other states?
  # end

  # Calculate taxes.
  net = income - tax
  puts '--- Minnesota ---'
  printf "Net: %s Tax: %-20s\n", net, tax
end
