require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    User.destroy_all
    @user = User.create(name: "Jose", email: "jose@email.com", phone: "(82) 91177-6655", cpf: "123.456.789-11")
  end

  test "assigns all users to @users if query is empty or nil" do
    user2 = User.create(name: "Maria", email: "maria@email.com", phone: "(82) 99977-6655", cpf: "123.456.789-00")

    get users_url, params: { query: "" }
    assert_equal [@user, user2], assigns(:users)
  end

  test "assigns users matching the query to @users" do
    get users_url, params: { query: "Jose" }

    assert_equal [@user], assigns(:users)
  end

  test "renders the index template" do
    get users_url

    assert_response :success
    assert_template :index
  end

  test "renders the users list partial as text" do
    get users_url, as: :text

    assert_response :success
    assert_template partial: "users/_list"
  end

  test "assigns the requested user to @user" do
    get user_url(@user)

    assert_equal @user, assigns(:user)
  end

  test "renders the show template" do
    get user_url(@user)

    assert_response :success
    assert_template :show
  end

  test "assigns a new user to @user" do
    get new_user_url

    assert_instance_of User, assigns(:user)
    assert assigns(:user).new_record?
  end

  test "renders the new template" do
    get new_user_url

    assert_response :success
    assert_template :new
  end

  test "assigns the requested edit user to @user" do
    get edit_user_url(@user)

    assert_equal @user, assigns(:user)
  end

  test "renders the edit template" do
    get edit_user_url(@user)

    assert_response :success
    assert_template :edit
  end

  test "creates a new user with valid parameters" do
    assert_difference("User.count") do
      post users_url, params: { user: { name: "Antonio", email: "antonio@email.com", phone: "(82) 98877-6655", cpf: "123.456.789-00"} }
    end
    assert_redirected_to user_url(User.last)
    assert_equal "User was successfully created.", flash[:notice]
  end

  test "does not create a new user with invalid parameters" do
    assert_no_difference("User.count") do
      post users_url, params: { user: {name: "Jose", email: "", phone: "", cpf: ""} }
    end
    assert_template :new
    assert_response :unprocessable_entity
    assert_includes response.body, "Please review the problems below:"
  end

  test "updates the requested user with valid parameters" do
    user = User.create(name: "Antonio", email: "antonio@email.com", phone: "(82) 98877-6655", cpf: "123.456.789-00")
    patch user_url(user), params: { user: { name: "Maria" } }

    user.reload
    assert_equal "Maria", user.name
    assert_redirected_to user_url(user)
    assert_equal "User was successfully updated.", flash[:notice]
  end

  test "does not update the requested user with invalid parameters" do
    user = User.create(name: "Antonio", email: "antonio@email.com", phone: "(82) 98877-6655", cpf: "123.456.789-00")
    patch user_url(user), params: { user: { email: "" } }

    user.reload
    assert_equal "antonio@email.com", user.email
    assert_template :edit
    assert_response :unprocessable_entity
    assert_includes response.body, "Please review the problems below:"
  end

  test "destroys the requested user" do
    user = User.create(name: "Antonio", email: "antonio@email.com", phone: "(82) 98877-6655", cpf: "123.456.789-00")

    assert_difference("User.count", -1) do
      delete user_url(user)
    end
    assert_redirected_to users_url
    assert_equal "User was successfully destroyed.", flash[:notice]
  end
end
