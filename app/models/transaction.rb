class Transaction < ApplicationRecord
  belongs_to :account

  validates :amount, numericality: { greater_than: 0 }
  validates :reference, presence: true

  enum :transaction_type, {
    deposit: "deposit",
    withdrawal: "withdrawal",
    transfer: "transfer"
  }

  enum :direction, {
    credit: "credit",
    debit: "debit"
  }
end
