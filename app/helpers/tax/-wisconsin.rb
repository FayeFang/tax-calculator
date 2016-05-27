
def wisconsin(income, status, pct)
  case status
  when 'single'
    std_exmp = 700
  when /p\s+(\w+)/
    dumpVariable(Regexp.last_match(1))

  when 'married_filing_seperately'
    std_exmp = 700
  when 'head_of_household'
    std_exmp = 1400
  when 'married', 'widow'
    std_exmp = 1400
  else
    print 'Illegal command'
  end

  agi = income
  agi *= pct
  std_exmp *= pct
  puts(agi)
  printf "Income: %s\n", agi
  printf "Deductions: %s\n", std_exmp
  taxable_income = agi - std_exmp

  #
  # tax = 51173.69 + 0.123 * (income - 526443.00)
  #       ^Taxes paid in previous brackets
  #                    ^ Tax Rate
  #                            ^ Income
  #                                       ^ Income already taxed in previous brackets

  if status == 'single'
    tax = if taxable_income < 11_090.00
            0.04 * taxable_income
          elsif taxable_income <  22_190.00
            443.6 + 0.0584 * (taxable_income - 11_090.00)
          elsif taxable_income <  244_270.00
            1091.84 + 0.0627 * (taxable_income - 22_190.00)
          else
            15_016.26 + 0.0765 * (taxable_income - 244_270.00)

          end
  end

  if status == 'married'
    tax = if taxable_income < 14_790.00
            0.04 * taxable_income
          elsif taxable_income <   29_580.00
            591.60 + 0.0584 * (taxable_income - 14_790.00)
          elsif taxable_income <   325_700.00
            1455.00 + 0.0627 * (taxable_income - 29_580.00)
          else
            20_022.06 + 0.0765 * (taxable_income - 325_700.00)
          end
  end

  # Calculate taxes.
  printf "Tax Owed: %s\n", tax
  net = taxable_income - tax * pct
  puts '--- Wisconsin ---'
  printf "Net: %s Tax: %-20s\n", net, tax
end
