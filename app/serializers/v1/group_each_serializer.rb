class V1::GroupEachSerializer < V1::BaseSerializer
  attributes :id, :musical_id, :title, :status, :submit_start_at, :submit_end_at, :audition_date, :performance_date, :application_link
  has_one :musical, serializer: V1::MusicalSerializer
end