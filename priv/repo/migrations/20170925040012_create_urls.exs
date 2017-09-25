defmodule Shrtener.Repo.Migrations.CreateUrls do
  use Ecto.Migration

  def change do
    create table(:urls) do
      add :url, :string
      add :shortcode, :string
      add :visits, :integer, default: 0

      timestamps()
    end

    create unique_index(:urls, [:shortcode])
  end
end
