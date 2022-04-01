require "test_helper"

class IntervalTest < ActiveSupport::TestCase
  setup do
    [1, 2, 3, 4, 5].each do |day|
      (0..19).each do |hour|
        approved_on = Date.new 2021, 8, day
        published_at = Time.local 2021, 8, day, hour
        post = Post.create(title: "title, published_at: #{published_at.to_s}, approved_on: #{approved_on.to_s}", approved_on: approved_on, published_at: published_at)
      # p post
      end
    end
  end

  test "module 'ActsAsRailable' is existed" do
    assert_kind_of Module, ActsAsRailable
  end

  test "module 'Interval' is existed" do
    assert_kind_of Module, ActsAsRailable::Interval
  end

  test "date_field_interval works" do
    d1 = Date.new 2021, 8, 1
    d2 = Date.new 2021, 8, 2
    cnt = Post.date_field_interval('approved_on', d1, d2).count
    assert_equal 40, cnt
  end

  test "time_field_interval works" do
    t1 = Time.new 2021, 8, 1, 0
    t2 = Time.new 2021, 8, 2, 10
    assert_equal 1, t1.day

    cnt = Post.time_field_interval('published_at', t1, t2).count
    assert_equal 31, cnt
  end

  test "utc_field_interval works" do
    t1 = Time.new(2021, 8, 1, 0).getutc
    t2 = Time.new(2021, 8, 2, 10).getutc
    assert_equal 31, t1.day

    cnt = Post.utc_field_interval('published_at', t1, t2).count
    assert_equal 31, cnt
  end

  test "local_field_interval works" do
    d1 = Date.new 2021, 8, 1
    d2 = Date.new 2021, 8, 2
    cnt = Post.local_field_interval('published_at', d1, d2).count
    assert_equal 40, cnt

    t1 = Time.new(2021, 8, 1, 0)
    t2 = Time.new(2021, 8, 2, 10)
    cnt = Post.local_field_interval('published_at', t1, t2).count
    assert_equal 40, cnt

    t1 = Time.new(2021, 8, 1, 0)
    t2 = Time.new(2021, 8, 1, 0)
    cnt = Post.local_field_interval('published_at', t1, t2).count
    assert_equal 20, cnt
  end
end
