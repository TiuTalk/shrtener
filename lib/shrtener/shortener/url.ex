defmodule Shrtener.Shortener.Url do
  use Ecto.Schema
  import Ecto.Changeset
  alias Shrtener.Shortener.Url

  @required ~w(url)a
  @optional ~w()a

  schema "urls" do
    field :shortcode, :string
    field :url, :string
    field :visits, :integer

    timestamps()
  end

  @doc false
  def changeset(%Url{} = url, attrs) do
    url
    |> cast(attrs, @required ++ @optional)
    |> validate_required(@required)
    |> validate_url(:url, message: "is not a valid URL")
    |> unique_constraint(:shortcode)
  end

  defp validate_url(changeset, field, options \\ []) do
    validate_change changeset, field, fn _, url ->
      case url |> String.to_charlist |> :http_uri.parse do
        {:ok, _} -> []
        {:error, msg} -> [{field, options[:message] || "invalid url: #{inspect msg}"}]
      end
    end
  end
end
