defmodule Shrtener.Shortener.Url do
  use Ecto.Schema
  import Ecto.Changeset
  alias Shrtener.Shortener.Url

  schema "urls" do
    field :shortcode, :string
    field :url, :string
    field :visits, :integer

    timestamps()
  end

  @doc false
  def changeset(%Url{} = url, attrs) do
    url
    |> cast(attrs, [:url, :shortcode, :visits])
    |> validate_required([:url, :shortcode])
    |> unique_constraint(:shortcode)
  end
end
