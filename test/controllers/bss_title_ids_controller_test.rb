require 'test_helper'

class BssTitleIdsControllerTest < ActionController::TestCase
  setup do
    @bss_title_id = bss_title_ids(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bss_title_ids)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bss_title_id" do
    assert_difference('BssTitleId.count') do
      post :create, bss_title_id: { bss_title_id: @bss_title_id.bss_title_id, episode_id: @bss_title_id.episode_id }
    end

    assert_redirected_to bss_title_id_path(assigns(:bss_title_id))
  end

  test "should show bss_title_id" do
    get :show, id: @bss_title_id
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bss_title_id
    assert_response :success
  end

  test "should update bss_title_id" do
    patch :update, id: @bss_title_id, bss_title_id: { bss_title_id: @bss_title_id.bss_title_id, episode_id: @bss_title_id.episode_id }
    assert_redirected_to bss_title_id_path(assigns(:bss_title_id))
  end

  test "should destroy bss_title_id" do
    assert_difference('BssTitleId.count', -1) do
      delete :destroy, id: @bss_title_id
    end

    assert_redirected_to bss_title_ids_path
  end
end
