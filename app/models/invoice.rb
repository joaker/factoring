class Invoice < ApplicationRecord
    validates :invoice_number, :due_date, :status, :scan, presence: true
    belongs_to :borrower
    has_one :fee
end
