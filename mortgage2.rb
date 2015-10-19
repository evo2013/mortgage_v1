require 'pry'
require 'pry-nav'

puts "
***********************************************************
          Welcome to the Mortgage Calculator App!
      Provide the details of your expected bank loan
              We'll calculate the rest...
***********************************************************\n "

name = ''
loop do
  puts "\nWhat is your name?\n"
  name = Kernel.gets().chomp().capitalize
  if name.empty?()
    puts "Incorrect entry. You must input a name to continue"
  else
    break
  end
end

loop do
  puts "\n#{name}, what is the total dollar loan amount you seek?\n"
  loan = Kernel.gets().chomp().to_i

  puts "\nHow many years is the mortgage?\n"
  years = Kernel.gets().chomp().to_i

  puts "\nWhat is the Annual Percentage Rate (APR) on the loan (i.e. 7.5)?\n"
  apr = Kernel.gets().chomp().to_f

  puts "\n...Calculating your payments now ...\n"
  months = years * 12  
  mpr = (apr/100)/12.0  
  top_pay =  (((1 + mpr).round(9))**months).round(9)
  top_pay2 = (mpr * top_pay).round(10) 
  top_payment = loan * top_pay2
  btm_payment = (top_pay - 1).round(9)
  monthly_payment = (top_payment/btm_payment).round(2)
  total_payment = monthly_payment * months
  one_year = monthly_payment * 12
  remaining  = total_payment - one_year
  sleep 1

  # puts "\nHere is your repayment information on a $#{loan}.00 loan with #{apr}% APR\n"
  puts "\nMonthly interest rate: #{(mpr*100).round(2)}%\n"
  puts "\nTotal loan duration: #{months} months\n"
  puts "\nYour fixed monthly payment: $#{monthly_payment}\n"
  puts "\nAfter 1 year, you would have paid: $#{one_year} and would have $#{remaining} left to repay.\n"

  puts "\nWould you like to continue & calculate another mortgage? (Y or N)?\n"
  continue = Kernel.gets().chomp()
  break unless continue.downcase().start_with?('y')
end

puts "Good-bye from the Mortgage Calculator!"