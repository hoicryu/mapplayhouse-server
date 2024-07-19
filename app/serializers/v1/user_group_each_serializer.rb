class V1::UserGroupEachSerializer < V1::BaseSerializer
  attributes :id, :group_id, :user_id, :status
  has_one :group, serializer: V1::GroupSerializer

end