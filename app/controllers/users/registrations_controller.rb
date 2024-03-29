module Users
  class RegistrationsController < Devise::RegistrationsController
    protect_from_forgery with: :exception
    skip_before_action :verify_authenticity_token

    def create
      if User.find_by(phone: params[:user].dig("phone")).present?
        render json: { error: '이미 가입한 사용자입니다.'}, status: :ok and return
      else
        super do |user|
          if user.persisted? || (params[:user].dig("provider").present? && params[:user].dig("uid").present?)
            if resource.active_for_authentication?
              if params[:user].dig("provider").present? && params[:user].dig("uid").present?
                user.provider = params[:user].dig("provider")
                user.uid = params[:user].dig("uid")
                user.password = Devise.friendly_token
                user.save
              end

              payload = { user_id: user.id, user: PayloadSerializer.new.serialize(user) }
              session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
              tokens = session.login

              response.set_cookie(
                JWTSessions.access_cookie,
                value: tokens[:access],
                httponly: true,
                secure: Rails.env.production?
              )

              render json: { csrf: tokens[:csrf], token: tokens[:access] } and return
            else
              render json: { error: I18n.t("devise.registrations.signed_up_but_inactive") }, status: :locked and return
            end
          else
            render json: { error: user.errors.full_messages.join(" ") }, status: :unprocessable_entity and return
          end
        end
      end
    end
  end
end
