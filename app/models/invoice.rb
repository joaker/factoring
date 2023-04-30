class Invoice < ApplicationRecord
    validates :invoice_number, :due_date, :status, :scan, presence: true
end
