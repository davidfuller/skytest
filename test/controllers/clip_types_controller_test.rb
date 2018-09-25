require 'test_helper'

class ClipTypesControllerTest < ActionController::TestCase
  setup do
    @clip_type = clip_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:clip_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create clip_type" do
    assert_difference('ClipType.count') do
      post :create, clip_type: { default_duration: @clip_type.default_duration, default_has_audio: @clip_type.default_has_audio, description: @clip_type.description, name: @clip_type.name }
    end

    assert_redirected_to clip_type_path(assigns(:clip_type))
  end

  test "should show clip_type" do
    get :show, id: @clip_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @clip_type
    assert_response :success
  end

  test "should update clip_type" do
    patch :update, id: @clip_type, clip_type: { default_duration: @clip_type.default_duration, default_has_audio: @clip_type.default_has_audio, description: @clip_type.description, name: @clip_type.name }
    assert_redirected_to clip_type_path(assigns(:clip_type))
  end

  test "should destroy clip_type" do
    assert_difference('ClipType.count', -1) do
      delete :destroy, id: @clip_type
    end

    assert_redirected_to clip_types_path
  end
end
