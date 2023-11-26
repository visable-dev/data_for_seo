defmodule DataForSeo.DataModel.Labs.Google.AvgBackLinksInfo do
  use DataForSeo.DataModel.Entity

  @primary_key false
  embedded_schema do
    field(:se_type, :string)
    field(:backlinks, :float)
    field(:dofollow, :float)
    field(:referring_pages, :float)
    field(:referring_domains, :float)
    field(:referring_main_domains, :float)
    field(:rank, :float)
    field(:main_domain_rank, :float)
    field(:last_updated_time, :utc_datetime)
  end

  @fields ~w(
      se_type
      backlinks
      dofollow
      referring_pages
      referring_domains
      referring_main_domains
      rank
      main_domain_rank
      last_updated_time
      )a

  def changeset(struct, data) do
    data = parse_utc_datetime_at_field(data, "last_updated_time")
    cast(struct, data, @fields)
  end
end
