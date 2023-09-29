defmodule EllionApi.Auth.Users.User.All do
  # credo:disable-for-this-file Credo.Check.Readability.ModuleDoc

  alias EllionApi.Auth.Users.User
  alias EllionApi.Repo

  @spec call :: list
  def call, do: Repo.all(User)
end
