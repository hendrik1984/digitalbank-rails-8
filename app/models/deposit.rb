class Deposit < ApplicationRecord
  belongs_to :account
  has_one :payment

  validates :amount, numericality: { greater_than: 0 }
  validates :reference, presence: true, uniqueness: true

  enum :status, {
    pending: "pending",
    completed: "completed",
    failed: "failed",
    cancelled: "cancelled"
  }


end
#deposit = Deposit.new(amount: 500000, reference: 'DEP-TEST-002'); 
#payment = deposit.build_payment(amount: 500000, reference: 'PAY-TEST-002'); 
#puts payment.deposit == deposit"