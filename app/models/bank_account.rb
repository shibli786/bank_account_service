class BankAccount < ApplicationRecord

  # id:integer, 
  # account_number:integer
  # balance:float, 
  # type:integer

  self.inheritance_column = nil

  validates :type ,presence: true
  validates :balance, presence: true
  validates :account_number, presence: true

  validate :ensure_minimum_balance, on:  [:update]


  
  ACCOUNT_TYPES = {checking: 0, savings: 1} # each user has one of each
  MIN_BALANCE = 10000.00 #all users are rich
  PERCENT = 0.25
  scope :checking, -> {where(type: ACCOUNT_TYPES[:checking])}
  scope :savings, -> {where(type: ACCOUNT_TYPES[:savings])}

  def self.transfer_to_savings(account_id,amount_to_transfer)
    savings_account = self.savings.find_by_account_number(account_id)
    checking_account = self.checking.find_by_account_number(account_id)
  

    BankAccount.transaction do
      begin
        checking_account.balance -= amount_to_transfer
        checking_account.save!
       
        savings_account.balance += amount_to_transfer
        savings_account.save!

        true
     rescue  => e
      
       Rails.logger.info { e.message }
       false
     end
    end

 end

  def magic_convert_savings_percent_to_amount
    # Magic code that will convert savings_percent and do error chekcing and
    # then some up with amount based on balance
     balance * PERCENT  
  end

  def has_minimum_balance?
    balance - magic_convert_savings_percent_to_amount  >= MIN_BALANCE
  end

  private

  def ensure_minimum_balance
    return if balance >= MIN_BALANCE

    errors.add(:balance, "can't be less than #{MIN_BALANCE}")
  end

end
