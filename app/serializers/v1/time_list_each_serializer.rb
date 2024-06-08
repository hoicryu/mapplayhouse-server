class V1::TimeListEachSerializer < V1::BaseSerializer
  attributes :id, :start_time, :end_time

  def start_time
    object.start_at.strftime("%H:%M")
  end

  def end_time
    object.end_at.strftime("%H:%M")
  end
end