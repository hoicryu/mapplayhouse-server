class V1::VideosController < V1::BaseController
  def index
    videos = Video.home
    render json: serialize(videos)
  end
end
