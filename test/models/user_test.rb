require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Jose", email: "jose@email.com", cpf: "123.456.789-00", phone: "(00) 0000-0000")
  end

  test "valid user with valid attributes" do
    assert @user.valid?
  end

  test "invalid without a name" do
    @user.name = nil
    assert_not @user.valid?
  end

  test "invalid without an email" do
    @user.email = nil
    assert_not @user.valid?
  end

  test "invalid with an invalid email format" do
    @user.email = "invalid_email"
    assert_not @user.valid?
  end

  test "invalid with a duplicate email" do
    User.create(name: "Maria", email: "jose@email.com", cpf: "987.654.321-00", phone: "(11) 1111-1111")
    assert_not @user.valid?
  end

  test "invalid without a cpf" do
    @user.cpf = nil
    assert_not @user.valid?
  end

  test "invalid with an invalid cpf format" do
    @user.cpf = "12345678900"
    assert_not @user.valid?
  end

  test "invalid with a duplicate cpf" do
    User.create(name: "Maria", email: "maria@email.com", cpf: "123.456.789-00", phone: "(11) 1111-1111")
    assert_not @user.valid?
  end

  test "invalid without a phone" do
    @user.phone = nil
    assert_not @user.valid?
  end

  test "invalid with an invalid phone format" do
    @user.phone = "1234567890"
    assert_not @user.valid?
  end

  test "invalid with a duplicate phone" do
    User.create(name: "Maria", email: "maria@email.com", cpf: "987.654.321-00", phone: "(00) 0000-0000")
    assert_not @user.valid?
  end

  test "search_by_all_fields returns matching users" do
    user = User.create(name: "Jose", email: "jose@email.com", cpf: "123.456.789-00", phone: "(00) 0000-0000")

    assert_includes User.search_by_all_fields("Jose"), user
    assert_includes User.search_by_all_fields("jose@email.com"), user
    assert_includes User.search_by_all_fields("(00) 0000-0000"), user
    assert_includes User.search_by_all_fields("123.456.789-00"), user
  end

  test "search_by_all_fields does not return non-matching users" do
    user = User.create(name: "Jose", email: "jose@email.com", cpf: "123.456.789-00", phone: "(00) 0000-0000")

    assert_not_includes User.search_by_all_fields("NonExistent"), user
    assert_not_includes User.search_by_all_fields("nonexistent@example.com"), user
    assert_not_includes User.search_by_all_fields("(99) 9999-9999"), user
    assert_not_includes User.search_by_all_fields("98765432100"), user
  end
end
