class V1::ReservationEachSerializer < V1::BaseSerializer
  attributes :id, :user_id, :status, :start_at, :end_at, :note, :num_of_people, :reason_for_rejection, :group_id 
  has_one :group, serializer: V1::GroupSerializer
  
end