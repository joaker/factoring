require "test_helper"

class InvoiceTest < ActiveSupport::TestCase
  test 'valid invoice' do
    invoice = Invoice.new(borrower_id: 1, fee_id: 1, invoice_number: 'ABC123', amount: 200.0, due_date: "2023-04-30 12:41:12".to_datetime, status: 'created', scan: 'iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==' )
    assert invoice.valid?
  end

  test 'invalid without invoice_number' do
    invoice = Invoice.new(borrower_id: 1, fee_id: 1, amount: 200.0, due_date: "2023-04-30 12:41:12".to_datetime, status: 'created', scan: 'iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==' )
    assert_not invoice.valid?, 'invoice is not valid without a invoice_number'
    assert_not_nil invoice.errors[:invoice_number], 'no validation errors for invoice_number present'
  end

  test 'invalid without amount is ok' do
    invoice = Invoice.new(borrower_id: 1, fee_id: 1, invoice_number: 'ABC123', due_date: "2023-04-30 12:41:12".to_datetime, status: 'created', scan: 'iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==' )
    assert invoice.valid?, 'invoice is valid without a amount'
    assert_empty invoice.errors[:amount], 'has validation errors for amount being nil'
  end

  test 'invalid without due_date' do
    invoice = Invoice.new(borrower_id: 1, fee_id: 1, invoice_number: 'ABC123', amount: 200.0, status: 'created', scan: 'iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==' )
    assert_not invoice.valid?, 'invoice is not valid without a due_date'
    assert_not_nil invoice.errors[:due_date], 'no validation errors for due_date present'
  end

  test 'invalid without status' do
    invoice = Invoice.new(borrower_id: 1, fee_id: 1, invoice_number: 'ABC123', amount: 200.0, due_date: "2023-04-30 12:41:12".to_datetime, scan: 'iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==' )
    assert_not invoice.valid?, 'invoice is not valid without a status'
    assert_not_nil invoice.errors[:status], 'no validation errors for status present'
  end

  test 'invalid without scan' do
    invoice = Invoice.new(borrower_id: 1, fee_id: 1, invoice_number: 'ABC123', amount: 200.0, due_date: "2023-04-30 12:41:12".to_datetime, status: 'created' )
    assert_not invoice.valid?, 'invoice is not valid without a scan'
    assert_not_nil invoice.errors[:scan], 'no validation errors for scan present'
  end

  test 'invalid without borrower id' do
    invoice = Invoice.new(fee_id: 1, invoice_number: 'ABC123', amount: 200.0, due_date: "2023-04-30 12:41:12".to_datetime, status: 'created' )
    assert_not invoice.valid?, 'invoice is not valid without a borrower id'
    assert_not_nil invoice.errors[:borrower_id], 'no validation errors for borrower id present'
  end

  test 'invalid without fee id' do
    invoice = Invoice.new(borrower_id: 1, invoice_number: 'ABC123', amount: 200.0, due_date: "2023-04-30 12:41:12".to_datetime, status: 'created' )
    assert_not invoice.valid?, 'invoice is not valid without a fee id'
    assert_not_nil invoice.errors[:fee_id], 'no validation errors for fee id present'
  end

end
