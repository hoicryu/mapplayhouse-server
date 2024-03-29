module JsonErrors
  extend ActiveSupport::Concern
  included do
    rescue_from ActiveRecord::RecordNotFound, with: :render_404
    rescue_from Exceptions::DefaultError, with: :render_404
    rescue_from ActionController::ParameterMissing, with: :render_400
    
    def render_400(errors = "required parameters invalid")
      render_errors(errors, 400)
    end

    def render_401(errors = "unauthorized access")
      render_errors(errors, 401)
    end

    # def un_authorized(exception)
    #   message = exception.message
    #   render json: { error: "Not authorized", msg: message }, status: :unauthorized
    # end

    def render_404(errors = "not found")
      render_errors(errors, 404)
    end

    def render_422(errors = "could not save data")
      render_errors(errors, 422)
    end

    def render_500(errors = "internal server error")
      render_errors(errors, 500)
    end

    def render_errors(errors, status = 400)
      data = {
        status: status,
        errorCode: status,
        errors: Array.wrap(errors)
      }
      render json: data, status: status
    end

    def render_object_errors(obj, status = 400)
      case obj
      when ActiveRecord::Base # ActiveModel::Model for Mongoid
        render_object_errors(obj.errors, status)
      when ActiveModel::Errors
        render_errors(obj.full_messages, status)
      else
        render_errors(obj, status)
      end
    end
  end
end
