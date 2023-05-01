class AddTotalAccruedToInvoice < ActiveRecord::Migration[7.0]
  def change
    add_column :invoices, :total_accrued, :decimal
  end
end
