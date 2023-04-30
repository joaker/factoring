class Migration < ActiveRecord::Migration[7.0]
  def change
    change_column :invoices, :scan, :text
  end
end
