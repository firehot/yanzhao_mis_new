require 'test_helper'

class InvoiceTypesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:invoice_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create invoice_type" do
    assert_difference('InvoiceType.count') do
      post :create, :invoice_type => { }
    end

    assert_redirected_to invoice_type_path(assigns(:invoice_type))
  end

  test "should show invoice_type" do
    get :show, :id => invoice_types(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => invoice_types(:one).to_param
    assert_response :success
  end

  test "should update invoice_type" do
    put :update, :id => invoice_types(:one).to_param, :invoice_type => { }
    assert_redirected_to invoice_type_path(assigns(:invoice_type))
  end

  test "should destroy invoice_type" do
    assert_difference('InvoiceType.count', -1) do
      delete :destroy, :id => invoice_types(:one).to_param
    end

    assert_redirected_to invoice_types_path
  end
end
