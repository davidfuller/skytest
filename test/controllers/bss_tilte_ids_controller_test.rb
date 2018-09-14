require 'test_helper'

class BssTilteIdsControllerTest < ActionController::TestCase
  setup do
    @bss_tilte_id = bss_tilte_ids(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bss_tilte_ids)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bss_tilte_id" do
    assert_difference('BssTilteId.count') do
      post :create, bss_tilte_id: { bss_title_id: @bss_tilte_id.bss_title_id, episode_id: @bss_tilte_id.episode_id }
    end

    assert_redirected_to bss_tilte_id_path(assigns(:bss_tilte_id))
  end

  test "should show bss_tilte_id" do
    get :show, id: @bss_tilte_id
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bss_tilte_id
    assert_response :success
  end

  test "should update bss_tilte_id" do
    patch :update, id: @bss_tilte_id, bss_tilte_id: { bss_title_id: @bss_tilte_id.bss_title_id, episode_id: @bss_tilte_id.episode_id }
    assert_redirected_to bss_tilte_id_path(assigns(:bss_tilte_id))
  end

  test "should destroy bss_tilte_id" do
    assert_difference('BssTilteId.count', -1) do
      delete :destroy, id: @bss_tilte_id
    end

    assert_redirected_to bss_tilte_ids_path
  end
end
