require 'test_helper'

class ComputerInvoiceShippmentsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:computer_invoice_shippments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create computer_invoice_shippment" do
    assert_difference('ComputerInvoiceShippment.count') do
      post :create, :computer_invoice_shippment => { }
    end

    assert_redirected_to computer_invoice_shippment_path(assigns(:computer_invoice_shippment))
  end

  test "should show computer_invoice_shippment" do
    get :show, :id => computer_invoice_shippments(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => computer_invoice_shippments(:one).to_param
    assert_response :success
  end

  test "should update computer_invoice_shippment" do
    put :update, :id => computer_invoice_shippments(:one).to_param, :computer_invoice_shippment => { }
    assert_redirected_to computer_invoice_shippment_path(assigns(:computer_invoice_shippment))
  end

  test "should destroy computer_invoice_shippment" do
    assert_difference('ComputerInvoiceShippment.count', -1) do
      delete :destroy, :id => computer_invoice_shippments(:one).to_param
    end

    assert_redirected_to computer_invoice_shippments_path
  end
end
