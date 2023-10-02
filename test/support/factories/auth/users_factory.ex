defmodule EllionApi.Factories.Auth.UsersFactory do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `EllionApi.Auth.Users` context.
  """

  # credo:disable-for-this-file Credo.Check.Readability.ModuleDoc
  # credo:disable-for-this-file Credo.Check.Readability.Specs

  alias EllionApi.Auth.Users.User
  alias EllionApi.Repo

  @doc """
  Generate a fake user attrs
  """
  def user_attrs do
    password = Base.encode64(:crypto.strong_rand_bytes(32), padding: false)

    %{
      id: Faker.UUID.v4(),
      name: Faker.Person.name(),
      email: Faker.Internet.email(),
      password: password,
      password_hash: Argon2.hash_pwd_salt(password),
      inactive: false,
      inserted_at: Faker.DateTime.backward(366),
      updated_at: DateTime.utc_now()
    }
  end

  def build_user do
    %User{}
    |> User.changeset_attrs(user_attrs())
    |> Ecto.Changeset.apply_action!(nil)
  end

  def insert_user do
    %User{}
    |> User.changeset_attrs(user_attrs())
    |> Repo.insert!()
  end
end
