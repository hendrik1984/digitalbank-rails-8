class Deposit < ApplicationRecord
  belongs_to :account

  validates :amount, numericality: { greater_than: 0 }
  validates :reference, presence: true, uniqueness: true

  enum :status, {
    pending: "pending",
    completed: "completed",
    failed: "failed",
    cancelled: "cancelled"
  }


end
