require "test_helper"

class CoreExtTest < ActiveSupport::TestCase
  test "numeric? string is a number" do
    assert_equal true, "78360".numeric?
    assert_equal false, "qibao360".numeric?
  end

  test "is_numeric? string is a number" do
    assert_equal true, "78360".is_numeric?
    assert_equal false, "qibao360".is_numeric?
  end

  test "deep_strip! deep strip string" do
    assert_equal 'qibao360', "  qibao360  ".deep_strip!
    assert_equal 'qibao 360', "  qibao   360  ".deep_strip!
  end

  test "deep_strip deep strip string" do
    assert_equal 'qibao360', "  qibao360  ".deep_strip
    assert_equal 'qibao 360', "  qibao   360  ".deep_strip
  end
end
