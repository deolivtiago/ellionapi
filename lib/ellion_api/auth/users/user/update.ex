defmodule EllionApi.Auth.Users.User.Update do
  # credo:disable-for-this-file Credo.Check.Readability.ModuleDoc

  alias EllionApi.Auth.Users.User
  alias EllionApi.Repo

  @spec call(User.t(), map) :: {:ok, User.t()} | {:error, Ecto.Changeset.t()}
  def call(%User{} = user, attrs) do
    user
    |> User.changeset_attrs(attrs)
    |> Repo.update()
  end
end
