require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
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
end
