class CreateFees < ActiveRecord::Migration[7.0]
  def change
    create_table :fees do |t|
      t.decimal :percentage

      t.timestamps
    end
  end
end
