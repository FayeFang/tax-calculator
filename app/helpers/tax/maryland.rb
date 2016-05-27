
def maryland(income, status, _homestate, pct)
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
    tax = if income < 1000.00
            0.02 * income
          elsif income <  2000.00
            20.00 +  0.03 * (income - 1000.00)
          elsif income <  3000.00
            50.00 +  0.04 * (income - 2000.00)
          elsif income <  100_000.00
            4697.50 +  0.0475 * (income - 3000.00)
          elsif income <  125_000.00
            5947.50 +  0.05 * (income - 100_000.00)
          elsif income <  150_000.00
            7260.00 +  0.0525 * (income - 125_000.00)
          elsif income <  250_000.00
            7260.00 +  0.052 * (income -  150_000.00)
          else
            12_760.00 + 0.0575 * (income - 250_000.00)
          end
  end

  if status == 'married'
    tax = if income < 1000.00
            0.02 * income
          elsif income <  2000.00
            20.00 +  0.03 * (income - 1000.00)
          elsif income <  3000.00
            50.00 +  0.04 * (income - 2000.00)
          elsif income <  150_000.00
            90.00 +  0.0475 * (income -  3000.00)
          elsif income <  175_000.00
            7072.50 +  0.05 * (income -  150_000.00)
          elsif income <  225_000.00
            8322.50 +  0.0525 * (income - 175_000.00)
          elsif income <  300_000.00
            10_947.50 +  0.052 * (income - 225_000.00)
          else
            15_072.50 + 0.0575 * (income - 300_000.00)
          end
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
  puts '--- Maryland ---'
  printf "Net: %s Tax: %-20s\n", net, tax
end
