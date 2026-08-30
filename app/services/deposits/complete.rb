class Deposits::Complete

    def initialize(deposit)
        @deposit = deposit
    end

    def call
        ActiveRecord::Base.transaction do
            deposit = Deposit.lock.find(@deposit.id)

            return if deposit.success?
            return if deposit.failed?

            @deposit.success!
            @deposit.account.increment!(:balance, @deposit.amount)
        end
    end
end