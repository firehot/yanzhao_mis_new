require 'test_helper'

class CommonInvoiceShippmentsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:common_invoice_shippments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create common_invoice_shippment" do
    assert_difference('CommonInvoiceShippment.count') do
      post :create, :common_invoice_shippment => { }
    end

    assert_redirected_to common_invoice_shippment_path(assigns(:common_invoice_shippment))
  end

  test "should show common_invoice_shippment" do
    get :show, :id => common_invoice_shippments(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => common_invoice_shippments(:one).to_param
    assert_response :success
  end

  test "should update common_invoice_shippment" do
    put :update, :id => common_invoice_shippments(:one).to_param, :common_invoice_shippment => { }
    assert_redirected_to common_invoice_shippment_path(assigns(:common_invoice_shippment))
  end

  test "should destroy common_invoice_shippment" do
    assert_difference('CommonInvoiceShippment.count', -1) do
      delete :destroy, :id => common_invoice_shippments(:one).to_param
    end

    assert_redirected_to common_invoice_shippments_path
  end
end
