
def dc(income, status, _pct)
  # Gross Income.
  # income = 1000000
  # Filing Status.
  @status = 'single' # Potential Options : case SINGLE: MARRIED_FILLING_SEPARATELY : HEAD_OF_HOUSEHOLD : MARRIED_FILLING_JOINTLY : WIDOW

  # Based on filing status select thresholds
  case status
  when 'single', 'married_filing_seperately'
    threshA = 150_000.0
    reduce_credit_every = 2500
    reduce_by = 0.02
    std_exmp = 1775
    std_ded = 5200.0
  when /p\s+(\w+)/
    dumpVariable(Regexp.last_match(1))
  when 'head_of_household'
    threshA = 150_000.0
    reduce_credit_every = 2500
    reduce_by = 0.02
    std_exmp = 1775
    std_ded = 6500.0
  when 'married', 'widow'
    threshA = 150_000.0
    reduce_credit_every = 2500
    reduce_by = 0.02
    std_exmp = 1775
    std_ded = 8350.0
  else
    print 'Illegal command'
  end

  agi = income

  if agi > threshA
    std_exmp -= ((agi - threshA) / reduce_by * reduce_credit_every)
    std_exmp = 0 if std_exmp < 0
  end

  agi = income - std_ded

  taxable_income = agi
  #
  # tax = 51173.69 + 0.123 * (income - 526443.00)
  #       ^Taxes paid in previous brackets
  #                    ^ Tax Rate
  #                            ^ Income
  #                                       ^ Income already taxed in previous brackets
  if status == 'single' || status == 'married'
    tax = if taxable_income < 10_000.00
            0.04 * taxable_income
          elsif taxable_income <  40_000.00
            400 + 0.06 * (taxable_income - 10_000.00)
          elsif taxable_income <  600_000.00
            2200 +  0.07 * (taxable_income -  40_000.00)
          elsif taxable_income <  350_000.00
            3600 +  0.085 * (taxable_income - 60_000.00)

          else
            28_250 + 0.0895 * (taxable_income - 350_000)
          end
  end

  # Itemized Deductions.
  # if taxable_income > threshA
  # income from other states?
  # end

  # Calculate taxes.
  net = income - tax
  puts '--- Wash, DC ---'
  printf "Net: %s Tax: %-20s\n", net, tax
end
