require "test_helper"

class FeesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @fee = fees(:one)
  end

  test "should show fee" do
    get fee_url(@fee), as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal @fee.percentage, json_response['percentage'].to_d
  end


  test "creates fee" do
    assert_difference('Fee.count', 1) do
      post '/fees', params: { fee: { percentage: 0.02 } }
    end

    assert_response :created
    assert_equal 0.02, Fee.last.percentage
  end
end
