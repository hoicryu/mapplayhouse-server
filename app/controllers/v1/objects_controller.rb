module V1
  class ObjectsController < V1::BaseController
    ALLOW_MODELS = %i[user notice group term application_form time_list reservation].freeze
    before_action :generate_class

    def index
      if params[:cursor] # Infinite Query
        cursor = params[:cursor].to_i
        objects = @object_class.ransack(index_params).result
        authorize_action objects
        objects = objects.page(cursor)
        render json: {
          objects: each_serialize(objects),
          total_count: objects.total_count,
          next_cursor: params[:cursor] && cursor < objects.total_pages ? cursor + 1 : false
        }
      else # Query
        objects = @object_class.ransack(index_params).result.page(params[:page])
        authorize_action objects
        render json: {
          objects: each_serialize(objects),
          total_count: objects.total_count,
          total_pages: objects.total_pages
        }
      end
    end

    def show
      object = @object_class.find(params[:id])
      authorize_action object
      render json: serialize(object)
    end

    def create
      object = current_api_user.send(@objects_name).new(model_params)
      authorize_action object
      object.save!
      render json: serialize(object)
    end

    def update
      object = @object_class.find(params[:id])
      authorize_action object
      object.update(model_params)
      render json: serialize(object)
    end

    def destroy
      object = @object_class.find(params[:id])
      authorize_action object
      object.destroy
      render json: serialize(object)
    end

    private

    def generate_class
      if ALLOW_MODELS.include?(params[:model_name]&.to_sym)
        @object_class = params[:model_name].classify.constantize
        @objects_name = params[:model_name].pluralize
      else
        raise ActiveRecord::RecordNotFound
      end
    end

    def authorize_action(object)
      object_class = @objects_name.pluralize.classify
      policy = begin
        "#{object_class}Policy".constantize
      rescue StandardError
        ApplicationPolicy
      end
      authorize object, policy_class: ApplicationPolicy
    end

    def index_params
      params.fetch(:q, {}).permit(@object_class::INDEX_PERMIT) if Object.const_defined?("#{@object_class}::INDEX_PERMIT", false) && params[:q].present?
    end

    def model_params
      params.require(params[:model_name]).permit(@object_class::PERMIT_COLUMNS)
    end
  end
end
