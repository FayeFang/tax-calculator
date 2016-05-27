
def georgia(income, status, pct)
  # Gross Income.
  # income = 1000000
  # Filing Status.
  @status = 'single' # Potential Options : case SINGLE: MARRIED_FILLING_SEPARATELY : HEAD_OF_HOUSEHOLD : MARRIED_FILLING_JOINTLY : WIDOW

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
    tax = if income < 750.00
            0.01 * income
          elsif income <  2250.00
            7.50 +  0.02 * (income - 750.00)
          elsif income <  3750.00
            3750.00 +  0.03 * (income - 2250.00)
          elsif income <  5250.00
            82.50 +  0.04 * (income - 3750.00)
          elsif income <  7000.00
            142.50 + 0.05 * (income - 5250.00)
          else
            230.00 + 0.06 * (income - 7000.00)
          end
  end

  if status == 'married'
    tax = if income < 1000.00
            0.01 * income
          elsif income <  3000.00
            10.00 + 0.02 * (income - 1000.00)
          elsif income <  5000.00
            50.00 + 0.03 * (income - 3000.00)
          elsif income <  7000.00
            110.00 +  0.04 * (income -  5000.00)
          elsif income <  10_000.00
            190.00 +  0.05 * (income -  7000.00)
          else
            340.00 + 0.06 * (income - 10_000.00)
          end
  end

  resident = if pct == 1
               true
             else
               false
             end
  # Standard Deductions.
  if resident == false
    std_ded = pct * std_ded
  else
    pct = 1
    std_ded = pct * std_ded
  end

  tax -= std_ded

  # Itemized Deductions.
  # if income > threshA
  # income from other states?
  # end

  # Calculate taxes.
  net = income - tax
  puts '--- Gerogia ---'
  printf "Net: %s Tax: %-20s\n", net, tax
end
