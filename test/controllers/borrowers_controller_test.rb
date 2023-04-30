require "test_helper"

class BorrowersControllerTest < ActionDispatch::IntegrationTest
  test "creates borrower" do
    assert_difference('Borrower.count', 1) do
      post '/borrowers', params: { borrower: { name: 'ACME Bank' } }
    end

    assert_response :created
    assert_equal 'ACME Bank', Borrower.last.name
  end
end
