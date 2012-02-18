require 'test_helper'

class OrgManagementFeeConfigsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:org_management_fee_configs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create org_management_fee_config" do
    assert_difference('OrgManagementFeeConfig.count') do
      post :create, :org_management_fee_config => { }
    end

    assert_redirected_to org_management_fee_config_path(assigns(:org_management_fee_config))
  end

  test "should show org_management_fee_config" do
    get :show, :id => org_management_fee_configs(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => org_management_fee_configs(:one).to_param
    assert_response :success
  end

  test "should update org_management_fee_config" do
    put :update, :id => org_management_fee_configs(:one).to_param, :org_management_fee_config => { }
    assert_redirected_to org_management_fee_config_path(assigns(:org_management_fee_config))
  end

  test "should destroy org_management_fee_config" do
    assert_difference('OrgManagementFeeConfig.count', -1) do
      delete :destroy, :id => org_management_fee_configs(:one).to_param
    end

    assert_redirected_to org_management_fee_configs_path
  end
end
