require 'test_helper'

class CommonInvoicesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:common_invoices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create common_invoice" do
    assert_difference('CommonInvoice.count') do
      post :create, :common_invoice => { }
    end

    assert_redirected_to common_invoice_path(assigns(:common_invoice))
  end

  test "should show common_invoice" do
    get :show, :id => common_invoices(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => common_invoices(:one).to_param
    assert_response :success
  end

  test "should update common_invoice" do
    put :update, :id => common_invoices(:one).to_param, :common_invoice => { }
    assert_redirected_to common_invoice_path(assigns(:common_invoice))
  end

  test "should destroy common_invoice" do
    assert_difference('CommonInvoice.count', -1) do
      delete :destroy, :id => common_invoices(:one).to_param
    end

    assert_redirected_to common_invoices_path
  end
end
