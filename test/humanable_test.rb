require "test_helper"

class HumanableTest < ActiveSupport::TestCase
  test "human_attribute_name return attribute locale name" do
    assert_equal '标题', Post.human_attribute_name('title')
  end

  test "i18n_attribute_name return attribute locale name" do
    assert_equal '标题', Post.i18n_attribute_name('title')
  end

  test "human_enum_name return enum locale name" do
    assert_equal '编辑中', Post.human_enum_name('status', 'edited')
  end

  test "human_enum_choices return enum locale choices" do
    choices = [["编辑中", "edited"], ["已发布", "published"], ["已审核", "approved"], ["已删除", "trashed"]]
    assert_equal choices, Post.human_enum_choices(:status)
  end

  test "human_array_choices return array locale choices" do
    choices = [["人民币", "CNY"], ["美元", "USD"], ["欧元", "EUR"], ["英镑", "GBP"], ["日元", "JPY"]]
    assert_equal choices, Post.human_array_choices(:currency)
  end
end
