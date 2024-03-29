module Users
  class SessionsController < Devise::SessionsController
    include JWTSessions::RailsAuthorization

    protect_from_forgery with: :exception
    skip_before_action :verify_authenticity_token
    skip_before_action :verify_signed_out_user, only: [:destroy]
    before_action :authorize_access_request!, only: [:destroy]
    # include JsonErrors

    def create
      super do |user|
        if user.persisted?
          user.update(last_market_id: params[:user][:last_market_id])
          payload = { user_id: user.id, user: PayloadSerializer.new.serialize(user) }
          session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
          tokens = session.login
          render json: { csrf: tokens[:csrf], token: tokens[:access] } and return
        else
          not_found
        end
      end
    end

    def destroy
      session = JWTSessions::Session.new(payload: payload)
      session.flush_by_access_payload
      render json: :ok and return
    end

    private

    def not_found
      render json: { error: "아이디 또는 비밀번호가 일치하지 않습니다." }, status: :not_found
    end
  end
end
