defmodule EllionApi.Auth.Users.User.Insert do
  # credo:disable-for-this-file Credo.Check.Readability.ModuleDoc

  alias EllionApi.Auth.Users.User
  alias EllionApi.Repo

  @spec call(map) :: {:ok, User.t()} | {:error, Ecto.Changeset.t()}
  def call(attrs \\ %{}) do
    %User{}
    |> User.changeset_attrs(attrs)
    |> Repo.insert()
  end
end
