require 'test_helper'

class DeedsControllerTest < ActionController::TestCase
  setup do
    @deed = deeds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:deeds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create deed" do
    assert_difference('Deed.count') do
      post :create, deed: { description: @deed.description, title: @deed.title }
    end

    assert_redirected_to deed_path(assigns(:deed))
  end

  test "should show deed" do
    get :show, id: @deed
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @deed
    assert_response :success
  end

  test "should update deed" do
    put :update, id: @deed, deed: { description: @deed.description, title: @deed.title }
    assert_redirected_to deed_path(assigns(:deed))
  end

  test "should destroy deed" do
    assert_difference('Deed.count', -1) do
      delete :destroy, id: @deed
    end

    assert_redirected_to deeds_path
  end
end
