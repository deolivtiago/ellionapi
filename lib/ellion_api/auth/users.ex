defmodule EllionApi.Auth.Users do
  @moduledoc """
  Users management.
  """

  alias EllionApi.Auth.Users.User

  @doc """
  Lists all users

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  @spec list_users :: list
  defdelegate list_users, to: User.All, as: :call

  @doc """
  Inserts an user

  ## Examples

      iex> insert_user(%{field: value})
      {:ok, %User{}}

      iex> insert_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec insert_user(map) :: {:ok, User.t()} | {:error, Ecto.Changeset.t()}
  defdelegate insert_user(attrs), to: User.Insert, as: :call

  @doc """
  Gets an user

  ## Examples

      iex> get_user(field, value)
      {:ok, %User{}}

      iex> get_user(field, bad_value)
      {:error, %Ecto.Changeset{}}

  """
  @spec get_user(atom, any) :: {:ok, User.t()} | {:error, Ecto.Changeset.t()}
  defdelegate get_user(field, value), to: User.Get, as: :call

  @doc """
  Updates an user

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec update_user(User.t(), map) :: {:ok, User.t()} | {:error, Ecto.Changeset.t()}
  defdelegate update_user(user, attrs), to: User.Update, as: :call

  @doc """
  Deletes an user

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  @spec delete_user(User.t()) :: {:ok, User.t()} | {:error, Ecto.Changeset.t()}
  defdelegate delete_user(user), to: User.Delete, as: :call
end
