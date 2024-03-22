module V1
  class PhoneCertificationsController < V1::BaseController
    # skip_before_action :authorize_access_request!

    def sms_auth
      code = params[:code]
      phone = params[:phone]
      if code.present? && phone.present?
        if (phone_certification = PhoneCertification.where(phone: phone).first)
          result = phone_certification.check_code(code)
        end
      elsif phone.present?
        result = PhoneCertification.generate_code(phone)
        puts result
      end
      render json: result
    end
  end
end
