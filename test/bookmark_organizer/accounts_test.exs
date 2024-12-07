defmodule BookmarkOrganizer.AccountsTest do
  use BookmarkOrganizer.DataCase

  alias BookmarkOrganizer.Accounts

  describe "users" do
    alias BookmarkOrganizer.Accounts.User

    test "register_user/1 with valid data creates a user" do
      valid_attrs = %{email: "test@example.com", password: "password123"}

      assert {:ok, %User{} = user} = Accounts.register_user(valid_attrs)
      assert user.email == "test@example.com"
      assert Bcrypt.verify_pass("password123", user.hashed_password)
    end

    test "authenticate_user/2 with valid credentials" do
      user_attrs = %{email: "test@example.com", password: "password123"}
      {:ok, user} = Accounts.register_user(user_attrs)

      assert {:ok, authenticated_user} =
               Accounts.authenticate_user("test@example.com", "password123")

      assert authenticated_user.id == user.id
    end
  end
end
