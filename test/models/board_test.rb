require 'test_helper'

class BoardTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
    @user.save # board wont validate unless user instance is also saved.
    @board = Board.new(title: "title", user_id: @user.id)
    @board.save
  end

  test "should be valid" do
    assert @board.valid?
  end

  test "user_id should be present" do
    @board.user_id = nil
    assert_not @board.valid?
  end

  test "Title should be present" do
    @board.title = "    "
    assert_not @board.valid?
  end

  test "title should be bounded at 50 characters" do
    @board.title = "a"*51
    assert_not @board.valid?
  end

  test "should be able to build event and references should be valid" do
    @user.save!
    @board = @user.boards.build(title: "test", user_id: @user.id)
    @board.save!
    assert @board.valid?
    @event = @board.events.build(title: "test", description: " ", repeater: 0,
                                 completed: false, tags: "", user: @user,
                                 start_date: Time.zone.now,
                                 deadline: Time.zone.now)
    @event.save!
    assert @event.valid?
    assert @event.board.valid?
    assert @event.user.valid?
    assert @board.events.first.valid?
    assert @user.events.first.valid?
    @board.title = ""
    assert_not @event.board.valid?
    @event.user.email = ""
    assert_not @event.user.valid?
  end
end
