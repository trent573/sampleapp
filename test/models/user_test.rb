require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end
  
  test "should be valid" do
    assert @user.valid?
  end
  
  test "name is not blank" do
    @user.name = "      "
    assert_not @user.valid?
  end
  
  test "email is not blank" do
    @user.email = "      "
    assert_not @user.valid?
  end
  
  test "valid email address" do
    valid_addresses = %w[user@example.com USER@example.COM A_US-ER@exa.mple.org 
                        first.last@example.jp first+last@example.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  
  test "invalid email" do
    invalid_addresses = %w[user@example,com user_at_example.org user.name@example.
                          first.last@exa_mple.com first.last@exa+mple.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  
  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test "password minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
end

