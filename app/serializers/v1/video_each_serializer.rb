class V1::VideoEachSerializer < V1::BaseSerializer
  attributes :title, :youtube_url, :_type, :body, :group_title

  def group_title
    object.group.title
  end
end