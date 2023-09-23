defmodule EllionApi.Repo do
  @moduledoc false
  use Ecto.Repo,
    otp_app: :ellion_api,
    adapter: Ecto.Adapters.Postgres
end
