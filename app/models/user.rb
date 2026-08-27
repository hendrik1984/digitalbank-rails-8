class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :status, {
    active: "active",
    suspended: "suspended",
    closed: "closed"
  }

  enum :role,  {
    customer: "customer",
    admin: "admin"
  }

  has_many :accounts
end
