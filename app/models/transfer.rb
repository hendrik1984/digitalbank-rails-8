class Transfer < ApplicationRecord
  belongs_to :source_account,
              class_name: "Account"

  belongs_to :destination_account,
              class_name: "Account"

  validates :amount, numericality: { greater_than: 0 }
  validates :reference, presence: true, uniqueness: true
  validates :status, presence: true
  
  enum :status,  {
    pending: "pending",
    completed: "completed",
    failed: "failed",
    cancelled: "cancelled"
  }

end
