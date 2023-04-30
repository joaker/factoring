class Borrower < ApplicationRecord
    validates :name, presence: true
end
