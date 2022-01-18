# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



(100000..120000).each_slice(1000).with_index do |arr, index|
  
 all_accounts = []
  arr.each do |number|
  	all_accounts << BankAccount.new({ account_number: number, type: 0,balance: Faker::Number.decimal(l_digits: 5, r_digits: 7) })
  	all_accounts << BankAccount.new({ account_number: number, type: 1,balance: Faker::Number.decimal(l_digits: 5, r_digits: 7) })
  end

  BankAccount.import all_accounts

  puts "1000 record imported..."
end