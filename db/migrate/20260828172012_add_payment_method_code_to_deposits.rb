class AddPaymentMethodCodeToDeposits < ActiveRecord::Migration[8.1]
  def change
    add_column :deposits, :payment_method_code, :string
  end
end
