require 'test_helper'

class PositionInfoItemsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:position_info_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create position_info_item" do
    assert_difference('PositionInfoItem.count') do
      post :create, :position_info_item => { }
    end

    assert_redirected_to position_info_item_path(assigns(:position_info_item))
  end

  test "should show position_info_item" do
    get :show, :id => position_info_items(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => position_info_items(:one).to_param
    assert_response :success
  end

  test "should update position_info_item" do
    put :update, :id => position_info_items(:one).to_param, :position_info_item => { }
    assert_redirected_to position_info_item_path(assigns(:position_info_item))
  end

  test "should destroy position_info_item" do
    assert_difference('PositionInfoItem.count', -1) do
      delete :destroy, :id => position_info_items(:one).to_param
    end

    assert_redirected_to position_info_items_path
  end
end
