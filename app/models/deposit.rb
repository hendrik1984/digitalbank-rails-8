class Deposit < ApplicationRecord
  belongs_to :account
  has_one :payment

  validate :generate_reference, on: :create

  validates :amount, presence: true
  validates :amount, numericality: { greater_than: 0 }
  validates :reference, presence: true, uniqueness: true
  validates :payment_method_code, presence: true
  validates :currency, presence: true, inclusion: { in: %w[IDR USD] }
  validates :status, presence: true

  enum :status, {
    pending: "pending",
    completed: "completed",
    failed: "failed",
    cancelled: "cancelled"
  }

  private

  def generate_reference
    self.reference ||= "DEP-#{SecureRandom.alphanumeric(10).upcase}"
  end
end
