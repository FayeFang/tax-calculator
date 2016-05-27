
def kansas(income, status, _homestate, pct)
  # Gross Income.
  # income = 1000000
  # Filing Status.
  @status = 'single' # Potential Options : case SINGLE: MARRIED_FILLING_SEPARATELY : HEAD_OF_HOUSEHOLD : MARRIED_FILLING_JOINTLY : WIDOW
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
    tax = if income < 15_000.00
            0.027 * income
          else
            405.00 + 0.049 * (income - 15_000.00)
          end
  end

  if status == 'married'
    tax = if income < 30_000.00
            0.027 * income
          else
            810.00 + 0.049 * (income - 30_000.00)
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
  puts '--- Kansas ---'
  printf "Net: %s Tax: %-20s\n", net, tax
end
