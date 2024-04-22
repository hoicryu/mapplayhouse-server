class V1::GroupsController < V1::BaseController
  def before_perform
      groups = Group.upcomming.order(performance_start_at: :asc)
    if groups.present?
      group = groups.first
    else
      group = Group.where("performance_end_at > ?", DateTime.current).first
    end
    
    render json: serialize(group)
  end
end
