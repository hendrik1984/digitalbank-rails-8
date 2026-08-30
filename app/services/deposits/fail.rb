class Deposits::Fail
    def initialize(deposit)
        @deposit = deposit
    end

    def call
        ActiveRecord::Base.transaction do
            deposit = Deposit.lock.find(@deposit.id)

            return if deposit.failed?
            
            deposit.failed!
        end
    end
end