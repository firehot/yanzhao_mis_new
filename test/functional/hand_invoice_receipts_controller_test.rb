require 'test_helper'

class HandInvoiceReceiptsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hand_invoice_receipts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hand_invoice_receipt" do
    assert_difference('HandInvoiceReceipt.count') do
      post :create, :hand_invoice_receipt => { }
    end

    assert_redirected_to hand_invoice_receipt_path(assigns(:hand_invoice_receipt))
  end

  test "should show hand_invoice_receipt" do
    get :show, :id => hand_invoice_receipts(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => hand_invoice_receipts(:one).to_param
    assert_response :success
  end

  test "should update hand_invoice_receipt" do
    put :update, :id => hand_invoice_receipts(:one).to_param, :hand_invoice_receipt => { }
    assert_redirected_to hand_invoice_receipt_path(assigns(:hand_invoice_receipt))
  end

  test "should destroy hand_invoice_receipt" do
    assert_difference('HandInvoiceReceipt.count', -1) do
      delete :destroy, :id => hand_invoice_receipts(:one).to_param
    end

    assert_redirected_to hand_invoice_receipts_path
  end
end
