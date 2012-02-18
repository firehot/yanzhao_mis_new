require 'test_helper'

class BudgetTablesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:budget_tables)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create budget_table" do
    assert_difference('BudgetTable.count') do
      post :create, :budget_table => { }
    end

    assert_redirected_to budget_table_path(assigns(:budget_table))
  end

  test "should show budget_table" do
    get :show, :id => budget_tables(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => budget_tables(:one).to_param
    assert_response :success
  end

  test "should update budget_table" do
    put :update, :id => budget_tables(:one).to_param, :budget_table => { }
    assert_redirected_to budget_table_path(assigns(:budget_table))
  end

  test "should destroy budget_table" do
    assert_difference('BudgetTable.count', -1) do
      delete :destroy, :id => budget_tables(:one).to_param
    end

    assert_redirected_to budget_tables_path
  end
end
