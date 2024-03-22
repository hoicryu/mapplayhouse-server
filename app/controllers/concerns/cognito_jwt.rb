module CognitoJwt
  extend ActiveSupport::Concern
  included do
    rescue_from JWT::JWKError, with: :un_authorized
    rescue_from JWT::DecodeError, with: :un_authorized

    def current_api_user
      @current_api_user ||= (jwt_token.present? ? User.find_by!(uid: sub) : nil)
    end

    def signed_in?
      jwt_token.present? && current_api_user.present?
    end

    def un_authorized(exception)
      message = exception.message
      render json: { error: "Not authorized", msg: message }, status: :unauthorized
    end

    def authorize_access_request!
      sub
      # csrf token 검증
    end

    protected

    def jwt_token
      request.headers["Authorization"].split(" ").last if request.headers["Authorization"].present?
    end

    def payload
      JWT.decode jwt_token, nil, true, { algorithms: [alg], jwks: jwks }
    end

    def claimless_payload
      JWT.decode jwt_token, nil, false
    end

    def jwks
      Rails.application.credentials[:jwks]
    end

    def jwk
      jwks[:keys].detect { |l| l[:kid] == kid }
    end

    def kid
      claimless_payload.dig(-1, "kid")
    end

    def alg
      claimless_payload.dig(-1, "alg")
    end

    def sub
      payload.dig(0, "sub")
    end
  end
end
