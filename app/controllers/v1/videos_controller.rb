class V1::VideosController < V1::BaseController
  def index
    videos = Video.home
    render json: each_serialize(videos)
  end
end
