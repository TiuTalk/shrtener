defmodule Shrtener.Shortener do
  @moduledoc """
  The Shortener context.
  """

  import Ecto.Query, warn: false
  alias Shrtener.Repo
  alias Shrtener.Shortener.Url
  alias Ecto.Changeset

  @hashid Hashids.new([min_len: 3, salt: System.get_env("SECRET_KEY_BASE") || ""])

  @doc """
  Gets a single url.

  Raises `Ecto.NoResultsError` if the Url does not exist.

  ## Examples

      iex> get_url!(123)
      %Url{}

      iex> get_url!(456)
      ** (Ecto.NoResultsError)

  """
  def get_url!(id), do: Repo.get!(Url, id)

  @doc """
  Creates a url.

  ## Examples

      iex> create_url(%{field: value})
      {:ok, %Url{}}

      iex> create_url(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_url(attrs \\ %{}) do
    %Url{}
    |> Url.changeset(attrs)
    |> Repo.insert()
    |> generate_shortcode
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking url changes.

  ## Examples

      iex> change_url(url)
      %Ecto.Changeset{source: %Url{}}

  """
  def change_url(%Url{} = url) do
    Url.changeset(url, %{})
  end

  defp generate_shortcode({:error, %Changeset{} = url}), do: {:error, url}
  defp generate_shortcode({:ok, %Url{} = url}) do
    url
    |> Changeset.change(shortcode: generate_random_shortcode(url.id))
    |> Repo.update
  end

  defp generate_random_shortcode(id) do
    Hashids.encode(@hashid, id)
  end
end
