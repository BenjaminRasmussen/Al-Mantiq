require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
    @user.save
    @user2 = User.new(name: "Example User2", email: "user2@example.com",
                     password: "foobar", password_confirmation: "foobar")
    @user2.save
  end


  test "user should be valid" do
    assert @user.valid?
  end

  test "user should have valid name" do
    @user.name = ""
    assert_not @user.valid?
    @user.name = "a"*100
    assert_not @user.valid?
  end

  test "user should have valid email" do
    @user.name = "Example user"
    @user.email = ""
    assert_not @user.valid?
    @user.email = "abc.com"
    assert_not @user.valid?
    @user.email = "user@example.com"
    assert @user.valid?
  end

  test "user should have valid password" do
    @user.password = @user.password_confirmation =  ""
    assert_not @user.valid?
    @user.password = @user.password_confirmation =  "abcde"
    assert_not @user.valid?
    @user.password = @user.password_confirmation =  "    "
    assert_not @user.valid?
    @user.password = @user.password_confirmation =  "foobar"
    assert @user.valid?
  end

  test "user save should work" do
    @user.name = "example Usr"
    @user.save
    assert @user.valid?
  end

  test "user should be able to build board and board_user_relations" do
    @user.save!
    @board = @user.boards.build(title: "test", user_id: @user.id)
    assert @board.valid?
    @rel = @user.board_user_relations.build(board_id: @board.id,
                                            user_id: @user2.id)
    @rel.valid?
  end

  test "should be able to build event and references should be valid" do
    @user.save!
    @board = @user.boards.build(title: "test", user_id: @user.id)
    @board.save!
    assert @board.valid?
    @event = @user.events.build(title: "test", description: " ", repeater: 0,
                                completed: false, tags: "", board: @board,
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
