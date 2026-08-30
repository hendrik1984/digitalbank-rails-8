class AddCurrencyToDeposits < ActiveRecord::Migration[8.1]
  def change
    add_column :deposits, :currency, :string
  end
end
