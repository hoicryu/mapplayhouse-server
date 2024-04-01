module Users
  class RefreshController < ApiController
    before_action :authorize_refresh_by_access_request!

    def create
      return render json: false if params[:refresh].empty?
      session = JWTSessions::Session.new(payload: claimless_payload, refresh_by_access_allowed: true)
      tokens = session.refresh_by_access_payload
      render json: { csrf: tokens[:csrf], token: tokens[:access] }
    end
  end
end
