require 'pry'
require 'pry-nav'
require 'yaml'

MESSAGES = YAML.load_file('mortgage_prompts.yml')

def messages(message)
  MESSAGES[message]
end

def prompt(message)
  Kernel.puts("#{message}")
  puts
end

def number?(args)
  integer?(args) || float?(args)
end

def integer?(args)
  args.to_i.to_s == args
end

def float?(args)
  args.to_f.to_s == args
end

puts "
***********************************************************
          Welcome to the Mortgage Calculator App!
      Provide the details of your expected bank loan
              We'll calculate the rest...
*********************************************************** "

name = ''

loop do
  prompt(MESSAGES['buyer_name'])
  name = Kernel.gets().chomp().capitalize
  if name.empty?()
    prompt(MESSAGES['no_name'])
  else
    break
  end
end

loop do
  puts "\n#{name},\n"
  
  loan = ''
  loop do
    prompt(MESSAGES['loan_amount'])
    loan = Kernel.gets().chomp()

    if number?(loan)
      break
    else 
      prompt(MESSAGES['loan_format'])
    end
  end

  years = ''
  loop do
    prompt(MESSAGES['years_mortgage'])
    years = Kernel.gets().chomp()

    if integer?(years)
      break
    else 
      prompt(MESSAGES['years_format'])
    end
  end

  apr = ''
  loop do
    prompt(MESSAGES['apr_mortgage'])
    apr = Kernel.gets().chomp()

    if number?(apr)
      break
    else 
      prompt(MESSAGES['apr_format'])
    end
  end

  puts
  prompt(MESSAGES['processing'])
  years_int = years.to_i
  loan_int = loan.to_i
  apr_float = apr.to_f

  months = years_int * 12  
  mpr = (apr_float/100)/12.0  
  top_pay =  (((1 + mpr).round(9))**months).round(9)
  top_pay2 = (mpr * top_pay).round(10) 
  top_payment = loan_int * top_pay2
  btm_payment = (top_pay - 1).round(9)
  monthly_payment = (top_payment/btm_payment).round(2)
  total_payment = monthly_payment * months
  one_year = monthly_payment * 12
  remaining  = total_payment - one_year
  sleep 1

  puts "\nHere is your repayment schedule on a #{years} year $#{loan}.00 loan with #{apr}% APR:\n"
  puts "\nMonthly interest rate: #{(mpr*100).round(2)}%\n"
  puts "\nTotal loan duration: #{months} months\n"
  puts "\nYour fixed monthly payment: $#{monthly_payment}\n"
  puts "\nAfter 1 year, you would have paid: $#{one_year.round(2)} and would have $#{remaining.round(2)} left to repay.\n"

  puts
  prompt(MESSAGES['new_calculation'])
  continue = Kernel.gets().chomp()
  break unless continue.downcase().start_with?('y')
end

prompt(MESSAGES['bye'])
