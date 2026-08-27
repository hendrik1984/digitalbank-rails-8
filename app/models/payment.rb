class Payment < ApplicationRecord
  belongs_to :deposit

  validates :amount, numericality: { greater_than: 0 }
  validates :reference, presence: true, uniqueness: true
  validates :status, presence: true

  enum :status, {
    pending: "pending",
    processing: "processing",
    completed: "completed",
    failed: "failed",
    cancelled: "cancelled"
  }
  
end
