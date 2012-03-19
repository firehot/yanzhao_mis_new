require 'test_helper'

class ComputerInvoiceReceiptsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:computer_invoice_receipts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create computer_invoice_receipt" do
    assert_difference('ComputerInvoiceReceipt.count') do
      post :create, :computer_invoice_receipt => { }
    end

    assert_redirected_to computer_invoice_receipt_path(assigns(:computer_invoice_receipt))
  end

  test "should show computer_invoice_receipt" do
    get :show, :id => computer_invoice_receipts(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => computer_invoice_receipts(:one).to_param
    assert_response :success
  end

  test "should update computer_invoice_receipt" do
    put :update, :id => computer_invoice_receipts(:one).to_param, :computer_invoice_receipt => { }
    assert_redirected_to computer_invoice_receipt_path(assigns(:computer_invoice_receipt))
  end

  test "should destroy computer_invoice_receipt" do
    assert_difference('ComputerInvoiceReceipt.count', -1) do
      delete :destroy, :id => computer_invoice_receipts(:one).to_param
    end

    assert_redirected_to computer_invoice_receipts_path
  end
end
