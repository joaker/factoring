class Fee < ApplicationRecord
    validates :percentage, presence: true
end
