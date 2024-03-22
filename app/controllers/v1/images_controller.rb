module V1
  class ImagesController < V1::BaseController
    def index
      images = Image.ransack(params[:q]).result
      render json: each_serialize(images)
    end

    def show
      image = Image.find(params[:id])
      render json: serialize(image)
    end

    def dropzone
      if params[:image].present?
        image = Image.create!(
          image: params[:image],
          imagable_type: params[:imagable_type],
          imagable_id: params[:imagable_id]
        )
        render json: image.id
      end
    end

    def destroy
      image = Image.find(params[:id])
      if image.imagable
        image.destroy if image.imagable.user_id == current_api_user.id
      else
        image.destroy
      end
    end
  end
end
