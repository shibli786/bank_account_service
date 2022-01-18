class CreateBankAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :bank_accounts do |t|  
      t.integer :account_number
      t.integer :type
      t.float   :balance 
      t.timestamps
    end
    add_index :bank_accounts,[:account_number,:type],unique: true
  end
end
