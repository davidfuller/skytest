require 'test_helper'

class TitleTest < ActiveSupport::TestCase
  test 'valid title' do
    title = Title.new(title: 'Test Title')
    assert title.valid?, "Title not created"
  end
  
  test 'invalid without title' do
    title = Title.new()
    assert title.valid?, 'title is valid without a title'
    assert_nil title.errors[:title], 'no validation error for title present'
  end
end
