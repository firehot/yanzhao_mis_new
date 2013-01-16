require 'test_helper'

class OrgInfosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:org_infos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create org_info" do
    assert_difference('OrgInfo.count') do
      post :create, :org_info => { }
    end

    assert_redirected_to org_info_path(assigns(:org_info))
  end

  test "should show org_info" do
    get :show, :id => org_infos(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => org_infos(:one).to_param
    assert_response :success
  end

  test "should update org_info" do
    put :update, :id => org_infos(:one).to_param, :org_info => { }
    assert_redirected_to org_info_path(assigns(:org_info))
  end

  test "should destroy org_info" do
    assert_difference('OrgInfo.count', -1) do
      delete :destroy, :id => org_infos(:one).to_param
    end

    assert_redirected_to org_infos_path
  end
end
