class Invoice < ApplicationRecord
    validates :invoice_number, :due_date, :status, :scan, presence: true
    belongs_to :borrower
    has_one :fee

    enum status: {
        created: 0,
        rejected: 1,
        approved: 2,
        purchased: 3,
        closed: 4
    }

    # validations
    validate :valid_status_transition

    private
    
    def valid_status_transition
        if status_changed?
            case status
            when "rejected"
                errors.add(:status, "may only transition to rejected from created") unless status_was == 'created'
            when "approved"
                errors.add(:status, "may only transition to approved from created") unless status_was == 'created'
            when "purchased"
                errors.add(:status, "may only transition to purchased from approved") unless status_was == 'approved'
            when "closed"
                errors.add(:status, "may only transition to closed from purchased") unless status_was == 'purchased'
            end
        end
    end
end
