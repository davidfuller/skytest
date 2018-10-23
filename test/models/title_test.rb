require 'test_helper'

class TitleTest < ActiveSupport::TestCase
  test 'valid title' do
    title = Title.new(title: 'Test Title', email: 'john@example.com')
    assert_not title.valid?, "Title not created"
  end

end
