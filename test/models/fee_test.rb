require "test_helper"

class FeeTest < ActiveSupport::TestCase
  test 'valid fee' do
    fee = Fee.new(percentage: 0.02 )
    assert fee.valid?
  end

  test 'invalid without percentage' do
    fee = Fee.new()
    assert_not fee.valid?, 'fee is not valid without a percentage'
    assert_not_nil fee.errors[:percentage], 'no validation errors for percentage present'
  end
end
