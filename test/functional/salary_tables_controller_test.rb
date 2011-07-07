require 'test_helper'

class SalaryTablesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:salary_tables)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create salary_table" do
    assert_difference('SalaryTable.count') do
      post :create, :salary_table => { }
    end

    assert_redirected_to salary_table_path(assigns(:salary_table))
  end

  test "should show salary_table" do
    get :show, :id => salary_tables(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => salary_tables(:one).to_param
    assert_response :success
  end

  test "should update salary_table" do
    put :update, :id => salary_tables(:one).to_param, :salary_table => { }
    assert_redirected_to salary_table_path(assigns(:salary_table))
  end

  test "should destroy salary_table" do
    assert_difference('SalaryTable.count', -1) do
      delete :destroy, :id => salary_tables(:one).to_param
    end

    assert_redirected_to salary_tables_path
  end
end
