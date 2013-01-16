require 'test_helper'

class PositionInfosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:position_infos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create position_info" do
    assert_difference('PositionInfo.count') do
      post :create, :position_info => { }
    end

    assert_redirected_to position_info_path(assigns(:position_info))
  end

  test "should show position_info" do
    get :show, :id => position_infos(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => position_infos(:one).to_param
    assert_response :success
  end

  test "should update position_info" do
    put :update, :id => position_infos(:one).to_param, :position_info => { }
    assert_redirected_to position_info_path(assigns(:position_info))
  end

  test "should destroy position_info" do
    assert_difference('PositionInfo.count', -1) do
      delete :destroy, :id => position_infos(:one).to_param
    end

    assert_redirected_to position_infos_path
  end
end
