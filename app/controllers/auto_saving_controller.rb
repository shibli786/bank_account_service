class AutoSavingController < ApplicationController
  skip_before_action :verify_authenticity_token


  # POST /auto_saving
  # body = {account_ids=[100003, 100044,...], savings_percent=0.025}
  # Backend processes call this nightly on specified accounts to save a fixed percentage from checking to savings.
  # the number of accounts processed by this POST is 10,000 or more. 
 
  def create
    checking_accounts = BankAccount.where("type = ? AND account_number IN (?)", BankAccount::ACCOUNT_TYPES[:checking], params[:account_ids])
 
    checking_accounts.each do |account|
      amount_to_transfer = account.magic_convert_savings_percent_to_amount
      if account.has_minimum_balance?
        BankAccount.transfer_to_savings(account.account_number,amount_to_transfer)
      end
    end
    render json: { status: "money transfered on accounts!" }
  end

end



