class CreateInvoices < ActiveRecord::Migration[7.0]
  def change
    create_table :invoices do |t|
      t.string :invoice_number, null: false, index: { unique: true }
      t.decimal :amount
      t.datetime :due_date
      t.integer :status
      t.binary :scan

      t.timestamps
    end
  end
end
