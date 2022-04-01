require "test_helper"

class HumanableTest < ActiveSupport::TestCase
  test "i18n_attribute_name return attribute locale name" do
    assert_equal '标题', Post.i18n_attribute_name(:title)
    assert_equal '标题', Post.i18n_attribute_name('title')
  end

  test "i18n_enum_name return enum locale name" do
    assert_equal '编辑中', Post.i18n_enum_name(:status, :edited)
    assert_equal '编辑中', Post.i18n_enum_name('status', 'edited')
  end

  test "i18n_enum_choices return enum locale choices" do
    choices = [["编辑中", "edited"], ["已发布", "published"], ["已审核", "approved"], ["已删除", "trashed"]]
    assert_equal choices, Post.i18n_enum_choices(:status)
    assert_equal choices, Post.i18n_enum_choices('status')
  end

  test "i18n_array_choices return array locale choices" do
    choices = [["人民币", "CNY"], ["美元", "USD"], ["欧元", "EUR"], ["英镑", "GBP"], ["日元", "JPY"]]
    assert_equal choices, Post.i18n_array_choices(:currency)
    assert_equal choices, Post.i18n_array_choices('currency')
  end

  test "i18n_action_name return action locale name" do
    assert_equal '修改', Post.i18n_action_name(:edit)
    assert_equal '详情', Post.i18n_action_name(:show)
    assert_equal '默认', Post.i18n_action_name(:none, '默认')
    assert_equal 'None', Post.i18n_action_name(:none)
  end
end
