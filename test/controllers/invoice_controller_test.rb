require "test_helper"

class InvoicesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get '/invoices/'
    assert_response :success
    assert_equal Invoice.all.to_json, @response.body
  end

  test "should show invoice" do
    invoice = invoices(:one)
    get "/invoices/#{invoice.id}"
    assert_response :success
    assert_equal invoice.to_json, response.body
  end

  test "should create invoice" do
    invoice_params = { borrower_id: 1, fee_id: 1, invoice_number: "INV001", amount: 200.0, due_date: "2023-04-30 12:41:12".to_datetime, status: 'created', scan: 'iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==' }
    assert_difference('Invoice.count') do
      post "/invoices", params: { invoice: invoice_params }
    end
    assert_response :created
    assert_equal Invoice.last.invoice_number, "INV001"
  end


  test "should update invoice status" do
    @invoice = invoices(:one)
    put "/invoices/#{@invoice.id}", params: { id: @invoice.id, status: "approved" }
    assert_response :success
    @invoice.reload
    assert_equal "approved", @invoice.status
  end

  test "should fail to update from 'created' to 'purchased'" do
    @invoice = invoices(:one)
    put "/invoices/#{@invoice.id}", params: { id: @invoice.id, status: "purchased" }
    assert_response :unprocessable_entity
    @invoice.reload
    assert_equal "created", @invoice.status
  end

  test "should fail to update from 'created' to 'closed'" do
    @invoice = invoices(:one)
    put "/invoices/#{@invoice.id}", params: { id: @invoice.id, status: "purchased" }
    assert_response :unprocessable_entity
    @invoice.reload
    assert_equal "created", @invoice.status
  end


  test "should accrue fees when closed" do
    @invoice = invoices(:one)
    
    # set the due date to 4 days ago
    @invoice.due_date = DateTime.now - 4.days;
    assert @invoice.save
    @invoice.reload

    put "/invoices/#{@invoice.id}", params: { id: @invoice.id, status: "approved" }
    assert_response :success
    @invoice.reload
    assert_equal "approved", @invoice.status

    put "/invoices/#{@invoice.id}", params: { id: @invoice.id, status: "purchased" }
    assert_response :success
    @invoice.reload
    assert_equal "purchased", @invoice.status

    put "/invoices/#{@invoice.id}", params: { id: @invoice.id, status: "closed" }
    assert_response :success
    @invoice.reload
    assert_equal "closed", @invoice.status
    @invoice.total_accrued == 4;
  end

end
