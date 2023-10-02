defmodule EllionWeb.Router do
  @moduledoc false
  use EllionWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", EllionWeb do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit]
  end
end
