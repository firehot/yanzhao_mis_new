require 'test_helper'

class InvoiceChecksControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:invoice_checks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create invoice_check" do
    assert_difference('InvoiceCheck.count') do
      post :create, :invoice_check => { }
    end

    assert_redirected_to invoice_check_path(assigns(:invoice_check))
  end

  test "should show invoice_check" do
    get :show, :id => invoice_checks(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => invoice_checks(:one).to_param
    assert_response :success
  end

  test "should update invoice_check" do
    put :update, :id => invoice_checks(:one).to_param, :invoice_check => { }
    assert_redirected_to invoice_check_path(assigns(:invoice_check))
  end

  test "should destroy invoice_check" do
    assert_difference('InvoiceCheck.count', -1) do
      delete :destroy, :id => invoice_checks(:one).to_param
    end

    assert_redirected_to invoice_checks_path
  end
end
