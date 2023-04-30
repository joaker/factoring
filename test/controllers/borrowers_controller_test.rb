require "test_helper"

class BorrowersControllerTest < ActionDispatch::IntegrationTest

  setup do
    @borrower = borrowers(:one)
  end

  test "should show borrower" do
    get borrower_url(@borrower), as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal @borrower.name, json_response['name']
  end


  test "creates borrower" do
    assert_difference('Borrower.count', 1) do
      post '/borrowers', params: { borrower: { name: 'ACME Bank' } }
    end

    assert_response :created
    assert_equal 'ACME Bank', Borrower.last.name
  end
end
