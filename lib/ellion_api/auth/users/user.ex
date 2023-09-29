defmodule EllionApi.Auth.Users.User do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  alias __MODULE__

  @type t :: %User{}

  @required_attrs ~w(name email password)a
  @optional_attrs ~w(inactive)a

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @timestamps_opts [type: :utc_datetime]

  schema "users" do
    field :inactive, :boolean, default: false
    field :name, :string
    field :password, :string, virtual: true, redact: true
    field :password_hash, :string
    field :email, :string

    timestamps()
  end

  @doc false
  @spec changeset_attrs(User.t(), map) :: Ecto.Changeset.t()
  def changeset_attrs(%User{} = user, attrs \\ %{}) do
    user
    |> cast(attrs, @required_attrs ++ @optional_attrs)
    |> validate_required(@required_attrs)
    |> unique_constraint(:id, name: :users_pkey)
    |> unique_constraint(:email)
    |> validate_length(:name, min: 2, max: 255)
    |> validate_length(:email, min: 3, max: 255)
    |> validate_length(:password, min: 6, max: 255)
    |> update_change(:email, &String.downcase/1)
    |> validate_format(:email, ~r/^[a-z0-9\-._+&#$?!]+[@][a-z0-9\-._+]+$/)
    |> put_pass_hash()
  end

  defp put_pass_hash(%{valid?: true, changes: %{password: password}} = changeset) do
    put_change(changeset, :password_hash, Argon2.hash_pwd_salt(password))
  end

  defp put_pass_hash(changeset), do: changeset
end
