class AddBorrowerToInvoices < ActiveRecord::Migration[7.0]
  def change
    add_reference :invoices, :borrower, foreign_key: true
    add_reference :invoices, :fee, foreign_key: true
  end
end
