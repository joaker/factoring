require "test_helper"

class BorrowerTest < ActiveSupport::TestCase
  test 'valid borrower' do
    borrower = Borrower.new(name: 'ACME Bank')
    assert borrower.valid?
  end

  test 'invalid without name' do
    borrower = Borrower.new()
    assert_not borrower.valid?, 'borrower is not valid without a name'
    assert_not_nil borrower.errors[:name], 'no validation errors for name present'
  end
end
