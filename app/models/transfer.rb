class Transfer < ApplicationRecord
  belongs_to :source_account,
              class_name: "Account"

  belongs_to :destination_account,
              class_name: "Account"

  validates :amount, numericality: { greater_than: 0 }
  validates :reference, presence: true, uniqueness: true
  validates :status, presence: true
  
  validate :source_and_destination_must_be_different

  enum :status,  {
    pending: "pending",
    completed: "completed",
    failed: "failed",
    cancelled: "cancelled"
  }

  def source_and_destination_must_be_different
    return if source_account.blank? || destination_account.blank?

    if source_account == destination_account
      errors.add(:destination_account, "must be different from source account")
    end
  end
end
