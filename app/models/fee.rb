class Fee < ApplicationRecord
    validates :percentage, presence: true
    belongs_to :invoice
end
