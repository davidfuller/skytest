require 'test_helper'

class ChannelTypesControllerTest < ActionController::TestCase
  setup do
    @channel_type = channel_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:channel_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create channel_type" do
    assert_difference('ChannelType.count') do
      post :create, channel_type: { has_promotion: @channel_type.has_promotion, name: @channel_type.name, tx: @channel_type.tx }
    end

    assert_redirected_to channel_types_path
  end

  test "should show channel_type" do
    get :show, id: @channel_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @channel_type
    assert_response :success
  end

  test "should update channel_type" do
    patch :update, id: @channel_type, channel_type: { has_promotion: @channel_type.has_promotion, name: @channel_type.name, tx: @channel_type.tx }
    assert_redirected_to channel_types_path
  end

  test "should destroy channel_type" do
    assert_difference('ChannelType.count', -1) do
      delete :destroy, id: @channel_type
    end

    assert_redirected_to channel_types_path
  end
end
