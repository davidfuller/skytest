require 'test_helper'

class TitleTest < ActiveSupport::TestCase
  test 'valid title' do
    title = Title.new(title: 'Test Title')
    assert title.valid?, "Title not created"
  end
  
  test 'invalid without title' do
    title = Title.new(title: ' ')
    refute title.valid?, 'title is valid without a title'
    assert_not_nil title.errors[:title], 'no validation error for title present'
  end
  
  test 'invalid duplicate' do
    title = Title.new(title: 'Duplicate title')
    title.save
    title1 = Title.new(title: 'Duplicate title')
    title1.save
    refute title1.valid?, 'duplicate title valid'
    assert_not_nil title1.errors[:title], 'no validation error forduplicate title'
  end
    
end
