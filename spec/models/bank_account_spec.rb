require 'rails_helper'

RSpec.describe BankAccount, type: :model do

  # Validation tests
  it { should validate_presence_of(:account_number) }
  it { should validate_presence_of(:type) }
  it { should validate_presence_of(:balance) }


  context "transfer_to_savings Failure will not happen if checking account does not have sufficient balance" do
   before(:each) do
     account_number = 100000
     @checking =  BankAccount.create({ account_number: account_number, type: 0,balance: 10500})
     @saving  = BankAccount.create({ account_number: account_number, type: 1,balance: 15000})
     @amount_to_transfer = @checking.magic_convert_savings_percent_to_amount
   end

   
    subject do
      BankAccount.transfer_to_savings(@checking.account_number,@amount_to_transfer)
    end

    it { expect(subject).to be_falsey }
    it {expect(@checking.balance).to eq(10500)}
    it {expect(@saving.balance).to eq(15000)}
  end

  context "transfer_to_savings Success when checking have sufficient balance " do
    before(:each) do
     account_number = 100001
     @checking =  BankAccount.create({ account_number: account_number, type: 0,balance: 25000})
     @saving  = BankAccount.create({ account_number: account_number, type: 1,balance: 15000})
     @amount_to_transfer = @checking.magic_convert_savings_percent_to_amount
   end

    subject do
      BankAccount.transfer_to_savings(@checking.account_number,@amount_to_transfer)
    end

    it { expect(subject).to eq(true) }

    
  end
  
end
