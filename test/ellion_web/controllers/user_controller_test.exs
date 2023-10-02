defmodule EllionWeb.UserControllerTest do
  use EllionWeb.ConnCase, async: true

  import EllionApi.Factories.Auth.UsersFactory

  @id_not_found Ecto.UUID.generate()

  setup %{conn: conn} do
    conn
    |> put_req_header("accept", "application/json")
    |> then(&{:ok, conn: &1})
  end

  describe "index/2 returns success" do
    setup [:insert_user]

    test "with a list of users when there are users", %{conn: conn, user: user} do
      conn = get(conn, ~p"/users")

      assert %{"data" => [user_data]} = json_response(conn, :ok)

      assert user_data["id"] == user.id
      assert user_data["email"] == user.email
      assert user_data["name"] == user.name
    end
  end

  describe "create/2 returns success" do
    setup [:insert_user]

    test "when the user parameters are valid", %{conn: conn} do
      user_params = user_attrs()

      conn = post(conn, ~p"/users", user: user_params)

      assert %{"data" => user_data} = json_response(conn, :created)

      assert user_data["id"]
      assert user_data["email"] == user_params.email
      assert user_data["name"] == user_params.name
    end
  end

  describe "create/2 returns error" do
    setup [:insert_user]

    test "when the user parameters are invalid", %{conn: conn} do
      user_params = %{email: "???", name: nil, password: "?"}

      conn = post(conn, ~p"/users", user: user_params)

      assert %{"errors" => errors} = json_response(conn, :unprocessable_entity)

      assert Enum.member?(errors["email"], "has invalid format")
      assert Enum.member?(errors["name"], "can't be blank")
      assert Enum.member?(errors["password"], "should be at least 6 character(s)")
    end
  end

  describe "show/2 returns success" do
    setup [:insert_user]

    test "when the user id is found", %{conn: conn, user: user} do
      conn = get(conn, ~p"/users/#{user}")

      assert %{"data" => user_data} = json_response(conn, :ok)

      assert user_data["id"] == user.id
      assert user_data["email"] == user.email
      assert user_data["name"] == user.name
    end
  end

  describe "show/2 returns error" do
    setup [:insert_user]

    test "when the user id is not found", %{conn: conn} do
      conn = get(conn, ~p"/users/#{@id_not_found}")

      assert %{"errors" => errors} = json_response(conn, :unprocessable_entity)

      assert Enum.member?(errors["id"], "not found")
    end
  end

  describe "update/2 returns success" do
    setup [:insert_user]

    test "when the user parameters are valid", %{conn: conn, user: user} do
      user_params = user_attrs()

      conn = put(conn, ~p"/users/#{user}", user: user_params)

      assert %{"data" => user_data} = json_response(conn, :ok)

      assert user_data["id"] == user.id
      assert user_data["email"] == user_params.email
      assert user_data["name"] == user_params.name
    end
  end

  describe "update/2 returns error" do
    setup [:insert_user]

    test "when the user parameters are invalid", %{conn: conn, user: user} do
      user_params = %{email: "?@?", name: "?", password: nil}

      conn = put(conn, ~p"/users/#{user}", user: user_params)

      assert %{"errors" => errors} = json_response(conn, :unprocessable_entity)

      assert Enum.member?(errors["email"], "has invalid format")
      assert Enum.member?(errors["name"], "should be at least 2 character(s)")
      assert Enum.member?(errors["password"], "can't be blank")
    end
  end

  describe "delete/2 returns success" do
    setup [:insert_user]

    test "when the user is found", %{conn: conn, user: user} do
      conn = delete(conn, ~p"/users/#{user}")

      assert response(conn, :no_content)
    end
  end

  describe "delete/2 returns error" do
    setup [:insert_user]

    test "when the user is not found", %{conn: conn} do
      conn = delete(conn, ~p"/users/#{@id_not_found}")

      assert %{"errors" => errors} = json_response(conn, :unprocessable_entity)

      assert Enum.member?(errors["id"], "not found")
    end
  end

  defp insert_user(_) do
    insert_user()
    |> Map.put(:password, nil)
    |> then(&{:ok, user: &1})
  end
end
