defmodule EllionApi.Auth.Users.User.Delete do
  # credo:disable-for-this-file Credo.Check.Readability.ModuleDoc

  alias EllionApi.Auth.Users.User
  alias EllionApi.Repo

  @spec call(User.t()) :: {:ok, User.t()} | {:error, Ecto.Changeset.t()}
  def call(%User{} = user), do: Repo.delete(user)
end
