class Transaction < ApplicationRecord
  belongs_to :account

  validates :amount, numericality: { greater_than: 0 }
  validates :reference, presence: true
  validates :transaction_type, presence: true
  validates :direction, presence: true
  validates :description, length: { maximum: 500 }, allow_blank: true

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
