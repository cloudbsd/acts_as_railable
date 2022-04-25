require "test_helper"

class RoutableTest < ActiveSupport::TestCase
  setup do
    approved_on = Date.new 2021, 8, 1
    published_at = Time.local 2021, 8, 1, 0
    post = Post.create(title: "title, published_at: #{published_at.to_s}, approved_on: #{approved_on.to_s}", approved_on: approved_on, published_at: published_at)
    post.comments.create content: 'nice article'
  end

  test "module 'ActsAsRailable' is existed" do
    assert_kind_of Module, ActsAsRailable
  end

  test "module 'Routable' is existed" do
    assert_kind_of Module, ActsAsRailable::Routable
  end

  test "native 'polymorphic_path' works" do
    # posts#index
    assert_equal "/posts", ActsAsRailable::Routable.polymorphic_path(Post)

    # posts#new
    post = Post.new
    assert_equal "/posts/new", ActsAsRailable::Routable.polymorphic_path(Post, action: :new)
    assert_equal "/posts/new", ActsAsRailable::Routable.polymorphic_path(post, action: :new)

    post = Post.first

    # posts#show
    assert_equal "/posts/#{post.id}", ActsAsRailable::Routable.polymorphic_path(post)

    # posts#edit
    assert_equal "/posts/#{post.id}/edit", ActsAsRailable::Routable.polymorphic_path(post, action: :edit)
    assert_equal "/posts/#{post.id}/edit", ActsAsRailable::Routable.polymorphic_path([post], action: :edit)
    assert_equal "/posts/#{post.id}/edit", ActsAsRailable::Routable.polymorphic_path([nil,post], action: :edit)

    # comments#new
    assert_equal "/posts/#{post.id}/comments/new", ActsAsRailable::Routable.polymorphic_path([post, Comment], action: :new)

    comment = post.comments.take

    # comments#show
    assert_equal "/posts/#{post.id}/comments/#{comment.id}", ActsAsRailable::Routable.polymorphic_path([post, comment])

    # comments#edit
    assert_equal "/posts/#{post.id}/comments/#{comment.id}/edit", ActsAsRailable::Routable.polymorphic_path([post, comment], action: :edit)
  end

  test "class 'polymorphic_path' works" do
    # posts#index
    assert_equal "/posts", Post.polymorphic_path(Post)

    # posts#new
    post = Post.new
    assert_equal "/posts/new", Post.polymorphic_path(Post, action: :new)
    assert_equal "/posts/new", Post.polymorphic_path(post, action: :new)

    post = Post.first

    # posts#show
    assert_equal "/posts/#{post.id}", Post.polymorphic_path(post)

    # posts#edit
    assert_equal "/posts/#{post.id}/edit", Post.polymorphic_path(post, action: :edit)
    assert_equal "/posts/#{post.id}/edit", Post.polymorphic_path([nil,post], action: :edit)

    # comments#new
    assert_equal "/posts/#{post.id}/comments/new", Comment.polymorphic_path([post, Comment], action: :new)

    comment = post.comments.take

    # comments#show
    assert_equal "/posts/#{post.id}/comments/#{comment.id}", Comment.polymorphic_path([post, comment])

    # comments#edit
    assert_equal "/posts/#{post.id}/comments/#{comment.id}/edit", Comment.polymorphic_path([post, comment], action: :edit)
  end

  test "action_path works" do
    # posts#index
    assert_equal "/posts", Post.action_path
    assert_equal "/posts", Post.action_path(:index)

    # posts#new
    post = Post.new
    assert_equal "/posts/new", Post.action_path(:new)
    assert_equal "/posts/new", post.action_path(:new)

    post = Post.first

    # posts#show
    assert_equal "/posts/#{post.id}", post.action_path
    assert_equal "/posts/#{post.id}", post.action_path(:show)

    # posts#edit
    assert_equal "/posts/#{post.id}/edit", post.action_path(:edit)

    # comments#new
    comment = post.comments.new
    assert_equal "/posts/#{post.id}/comments/new", Comment.action_path(:new, [post])
    assert_equal "/posts/#{post.id}/comments/new", comment.action_path(:new, [post])

    post = Post.first
    comment = post.comments.take

    # comments#show
    assert_equal "/posts/#{post.id}/comments/#{comment.id}", comment.action_path(:show, post)
    assert_equal "/posts/#{post.id}/comments/#{comment.id}", comment.action_path(nil, [post])
    assert_equal "/posts/#{post.id}/comments/#{comment.id}", comment.action_path(nil, [post, comment])

    # comments#edit
    assert_equal "/posts/#{post.id}/comments/#{comment.id}/edit", comment.action_path(:edit, [post])
    assert_equal "/posts/#{post.id}/comments/#{comment.id}/edit", comment.action_path(:edit, [post, comment])
  end
end
