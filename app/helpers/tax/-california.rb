def california(income, status, _pct)
  case status
  when 'single'
    threshA = 178_706.0
    std_ded = 4044.0
    std_exmp = 109
    reduce_credit_every = 2500
    reduce_by = 6
  when /p\s+(\w+)/
    dumpVariable(Regexp.last_match(1))

  when 'married_filing_seperately'
    threshA = 178_706.0
    std_ded = 4044.0
    std_exmp = 109
    reduce_credit_every = 1250
    reduce_by = 6
  when 'head_of_household'
    threshA = 268_063.0
    std_ded = 8088.0
    std_exmp = 109
    reduce_credit_every = 2500
    reduce_by = 6
  when 'married', 'widow'
    threshA = 357_417.0
    std_ded = 8088.0
    std_exmp = 218
    reduce_credit_every = 2500
    reduce_by = 12
  else
    print 'Illegal command'
  end

  # TAX ROUTINE
  # Calculate Adjusted Gross Income
  agi = income

  if agi > threshA
    std_exmp -= ((agi - threshA) / reduce_credit_every * reduce_by)
    std_exmp = 0 if std_exmp < 0
  end

  taxable_income = agi - std_ded

  # puts taxable_income
  #
  # tax = 51173.69 + 0.123 * (income - 526443.00)
  #       ^Taxes paid in previous brackets
  #                    ^ Tax Rate
  #                            ^ Income
  #                                       ^ Income already taxed in previous brackets
  # puts(taxable_income)
  if status == 'single'
    if taxable_income < 7850.00
      tax = 0.01 * taxable_income
    elsif taxable_income <  18_610.00
      tax = 78.50 +  0.02 * (taxable_income - 7850.00)
    elsif taxable_income <  29_372.00
      tax =   293.70 +  0.04 * (taxable_income -  18_610.00)
    elsif taxable_income <  40_773.00
      tax =   724.18 +  0.06 * (taxable_income -  29_372.00)
    elsif taxable_income <  51_530.00
      tax =  1408.24 +  0.08 * (taxable_income -  40_773.00)
    elsif taxable_income < 263_222.00
      tax =  2268.80 + 0.093 * (taxable_income -  51_530.00)
    elsif taxable_income < 315_866.00
      tax = 21_956.16 + 0.103 * (taxable_income - 263_222.00)
    elsif taxable_income < 526_443.00
      tax = 27_378.49 + 0.113 * (taxable_income - 315_866.00)
    elsif
        tax = 51_173.69 + 0.123 * (taxable_income - 526_443.00)
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

  taxable_income = agi - std_ded

  # California has a mental health tax of .01 on income > 1000000
  if taxable_income > 1_000_000
    mental_health_tax = 0.01 * (taxable_income - 1_000_000)
    tax += mental_health_tax
  end

  # Calculate taxes.
  net = taxable_income - tax
  puts '--- California ---'
  printf "Net: %s Tax: %-20s\n", net, tax
end
