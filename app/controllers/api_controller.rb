class ApiController < ActionController::API
  include Pundit
  include CognitoJwt
  # include JsonErrors
  rescue_from Pundit::NotAuthorizedError, with: :pundit_un_authorized

  def render_resource(resource)
    if resource.errors.empty?
      render json: resource
    else
      validation_error(resource)
    end
  end

  def validation_error(resource)
    render json: {
      errors: [
        {
          status: "400",
          title: "Bad Request",
          detail: resource.errors,
          code: "100"
        }
      ]
    }, status: :bad_request
  end

  protected
  def pundit_user
    current_api_user if request.headers["Authorization"]
  rescue StandardError
    nil
  end

  def signed_in?
    current_api_user.present?
  end

  def serialize(object, serializer_name: "#{object.class.name}Serializer", context: nil, only: [], except: [])
    self.class.module_parent.const_get(serializer_name.to_s).new(
      context: context,
      only: only,
      except: except
    ).serialize(object)
  end

  def each_serialize(objects, serializer_name: "#{objects.name}EachSerializer", context: nil, only: [], except: [])
    serializer = self.class.module_parent.const_get(serializer_name)
    includes_associations = [*serializer._descriptor.has_many_associations, *serializer._descriptor.has_one_associations]
    objects = objects.includes(*includes_associations.map(&:name_sym)) unless includes_associations.empty?
    Panko::ArraySerializer.new(
      objects,
      context: context,
      each_serializer: serializer,
      only: only,
      except: except
    ).to_a
  end

  def un_authorized(exception)
    message = exception.message
    render json: { error: "Not authorized", msg: message }, status: :unauthorized
  end

  def pundit_un_authorized(exception)
    message = exception.message
    render json: { error: "Pundit Error", msg: message }, status: :unauthorized
  end
end
