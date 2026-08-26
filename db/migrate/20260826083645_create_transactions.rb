class CreateTransactions < ActiveRecord::Migration[8.1]
  def change
    create_table :transactions do |t|
      t.references :account, null: false, foreign_key: true

      t.string :transaction_type, null: false

      t.string :direction, null: false

      t.decimal :amount,
                precision: 20,
                scale: 2,
                null: false

      t.string :reference, null: false

      t.text :description

      t.timestamps
    end

    add_index :transactions, :reference, unique: true
  end
end
