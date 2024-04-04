module V1
  class NoticesController < V1::BaseController

    def index
      notices = Notice.visible.order(position: :asc, created: :desc)
      render json: {
        notices: each_serialize(notices)
      }
    end

    private
  end
end
