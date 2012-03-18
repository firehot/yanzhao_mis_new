require 'test_helper'

class CommonInvoiceReceiptsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:common_invoice_receipts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create common_invoice_receipt" do
    assert_difference('CommonInvoiceReceipt.count') do
      post :create, :common_invoice_receipt => { }
    end

    assert_redirected_to common_invoice_receipt_path(assigns(:common_invoice_receipt))
  end

  test "should show common_invoice_receipt" do
    get :show, :id => common_invoice_receipts(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => common_invoice_receipts(:one).to_param
    assert_response :success
  end

  test "should update common_invoice_receipt" do
    put :update, :id => common_invoice_receipts(:one).to_param, :common_invoice_receipt => { }
    assert_redirected_to common_invoice_receipt_path(assigns(:common_invoice_receipt))
  end

  test "should destroy common_invoice_receipt" do
    assert_difference('CommonInvoiceReceipt.count', -1) do
      delete :destroy, :id => common_invoice_receipts(:one).to_param
    end

    assert_redirected_to common_invoice_receipts_path
  end
end
