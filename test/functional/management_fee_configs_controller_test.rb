require 'test_helper'

class ManagementFeeConfigsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:management_fee_configs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create management_fee_config" do
    assert_difference('ManagementFeeConfig.count') do
      post :create, :management_fee_config => { }
    end

    assert_redirected_to management_fee_config_path(assigns(:management_fee_config))
  end

  test "should show management_fee_config" do
    get :show, :id => management_fee_configs(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => management_fee_configs(:one).to_param
    assert_response :success
  end

  test "should update management_fee_config" do
    put :update, :id => management_fee_configs(:one).to_param, :management_fee_config => { }
    assert_redirected_to management_fee_config_path(assigns(:management_fee_config))
  end

  test "should destroy management_fee_config" do
    assert_difference('ManagementFeeConfig.count', -1) do
      delete :destroy, :id => management_fee_configs(:one).to_param
    end

    assert_redirected_to management_fee_configs_path
  end
end
