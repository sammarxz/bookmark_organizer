defmodule BookmarkOrganizer.Repo do
  use Ecto.Repo,
    otp_app: :bookmark_organizer,
    adapter: Ecto.Adapters.Postgres
end
