class Account < ApplicationRecord
  belongs_to :user
  has_many :accounts, dependent: :restrict_with_error
  has_many :deposits
  has_many :withdrawals
  
  has_many :outgoing_transfers,
            class_name: "Transfer",
            foreign_key: :source_account_id

  has_many :incoming_transfers,
            class_name: "Transfer",
            foreign_key: :destination_account_id

  has_many :transactions

  validates :account_number, presence: true, uniqueness: true
  validates :balance, numericality: { greater_than_or_equal_to: 0 }
  validates :status, presence: true

  enum :status, {
    active: "active",
    suspended: "suspended",
    closed: "closed"
  }
end
