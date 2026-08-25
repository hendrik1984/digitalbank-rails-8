class CreateDeposits < ActiveRecord::Migration[8.1]
  def change
    create_table :deposits do |t|
      t.references :account, null: false, foreign_key: true

      t.decimal :amount,
                precision: 20,
                scale: 2,
                null: false

      t.string :status,
                null: false,
                default: "pending"

      t.string :reference, null: false

      t.timestamps
    end

    add_index :deposits, :reference, unique: true
  end
end
