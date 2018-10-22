require 'test_helper'

class ClipsControllerTest < ActionController::TestCase
  setup do
    @clip = clips(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:clips)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create clip" do
    bss = bss_title_ids(:one)
    assert_difference('Clip.count') do
      post :create, clip: { audio_filename: @clip.audio_filename, clip_type_id: @clip.clip_type_id, completion: @clip.completion, duration: @clip.duration, end_episode: @clip.end_episode, end_season: @clip.end_season, filename: @clip.filename, first_use: @clip.first_use, folder_id: @clip.folder_id, has_audio: @clip.has_audio, last_use: @clip.last_use, name: @clip.name, note: @clip.note, season_generic: @clip.season_generic, start_episode: @clip.start_episode, start_season: @clip.start_season, status_id: @clip.status_id, totally_generic: @clip.totally_generic, user_id: @clip.user_id, dummy_bss_id: bss}
    end

    assert_redirected_to clips_path
  end

  test "should show clip" do
    get :show, id: @clip
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @clip
    assert_response :success
  end

  test "should update clip" do
    patch :update, id: @clip, clip: { audio_filename: @clip.audio_filename, clip_type_id: @clip.clip_type_id, completion: @clip.completion, duration: @clip.duration, end_episode: @clip.end_episode, end_season: @clip.end_season, filename: @clip.filename, first_use: @clip.first_use, folder_id: @clip.folder_id, has_audio: @clip.has_audio, last_use: @clip.last_use, name: @clip.name, note: @clip.note, season_generic: @clip.season_generic, start_episode: @clip.start_episode, start_season: @clip.start_season, status_id: @clip.status_id, totally_generic: @clip.totally_generic, user_id: @clip.user_id }
    assert_redirected_to clips_path
  end

  test "should destroy clip" do
    assert_difference('Clip.count', -1) do
      delete :destroy, id: @clip
    end

    assert_redirected_to clips_path
  end
end
