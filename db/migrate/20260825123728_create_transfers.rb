class CreateTransfers < ActiveRecord::Migration[8.1]
  def change
    create_table :transfers do |t|
      t.references :source_account,
                    null: false, 
                    foreign_key: { to_table: :accounts }

      t.references :destination_account, 
                    null: false, 
                    foreign_key: { to_table: :accounts }

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

    add_index :transfers, :reference, unique: true
  end
end
