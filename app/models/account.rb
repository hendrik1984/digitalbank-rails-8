class Account < ApplicationRecord
  belongs_to :user
  has_many :deposits

  validates :account_number, presence: true, uniqueness: true
  validates :balance, numericality: { greater_than_or_equal_to: 0 }

  enum :status, {
    active: "active",
    suspended: "suspended",
    closed: "closed"
  }
end
