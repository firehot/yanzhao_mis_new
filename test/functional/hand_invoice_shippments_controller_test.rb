require 'test_helper'

class HandInvoiceShippmentsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hand_invoice_shippments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hand_invoice_shippment" do
    assert_difference('HandInvoiceShippment.count') do
      post :create, :hand_invoice_shippment => { }
    end

    assert_redirected_to hand_invoice_shippment_path(assigns(:hand_invoice_shippment))
  end

  test "should show hand_invoice_shippment" do
    get :show, :id => hand_invoice_shippments(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => hand_invoice_shippments(:one).to_param
    assert_response :success
  end

  test "should update hand_invoice_shippment" do
    put :update, :id => hand_invoice_shippments(:one).to_param, :hand_invoice_shippment => { }
    assert_redirected_to hand_invoice_shippment_path(assigns(:hand_invoice_shippment))
  end

  test "should destroy hand_invoice_shippment" do
    assert_difference('HandInvoiceShippment.count', -1) do
      delete :destroy, :id => hand_invoice_shippments(:one).to_param
    end

    assert_redirected_to hand_invoice_shippments_path
  end
end
