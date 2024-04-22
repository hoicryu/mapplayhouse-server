class V1::GroupSerializer < V1::BaseSerializer
  attributes :id, :title, :musical_alias, :status, :audition_date, :submit_end_at, :performance_date, :submit_start_at, :application_link, :concert_hall
  has_one :musical, serializer: V1::MusicalSerializer
end