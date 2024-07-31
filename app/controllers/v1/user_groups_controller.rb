class V1::UserGroupsController < V1::BaseController
  def index
    user_groups = current_api_user.user_groups.joins(:group).where(groups: {status: Group.statuses.except(:done).values})
    render json: each_serialize(user_groups)
  end
end
