class SmsService
  attr_reader :phone

  def initialize(phone = nil)
    @phone = phone.gsub(/[^0-9A-Za-z]/, "")
  end

  def send_sms(message)
    result = false
    begin
      url = URI.parse("https://sslsms.cafe24.com/sms_sender.php")
      if Rails.env.production? || %w[01029560790].include?(phone)
        res = Net::HTTP.post_form(url, { user_id: "flyingmatesms",
                                         secure: "e45b071e54a9e9b47367873c42a03ff9",
                                         sphone1: "010", sphone2: "9391", sphone3: "6522",
                                         smsType: message.size > 60 ? "L" : "S",
                                         rphone: phone.to_s.gsub(/[^0-9]/, ""),
                                         msg: message })

        if res.body.include? "success"
          puts "SUCCESS"
          result = true
        else
          puts res.to_yaml
          puts "FAILURE"
        end
      end
    rescue StandardError
    end
    result
  end

  def send_kakao_notification(templateId = "sample", title, message)
    message ||= <<~TEXT
      샘플 메세지입니다.
      원하시는 내용으로 탬플릿을
      변경할 수 있습니다.
    TEXT
    # 혹시 전송이 안되면, 발송 프로필이 비활성화 됐을 수도 있으시 체크해주세요.
    if (message.present? && Rails.env.production?) || phone.to_s.gsub(/[^0-9]/, "") == "01026101173"
      request_params = {
        message_type: "AT",
        phn: phone.to_s.gsub(/[^0-9]/, ""),
        profile: "a743672517cfed0105795e682a40487671c44d3f",
        tmplId: templateId,
        msg: message,
        smsKind: message.length > 50 ? "L" : "S",
        msgSms: message,
        smsSender: "01093916522",
        smsLmsTit: title
      }
      messages = [request_params]
      begin
        response = HTTParty.post(
          "https://alimtalk-api.bizmsg.kr/v2/sender/send",
          body: JSON.dump(messages),
          headers: {
            "userId" => "flyingmate",
            "Content-Type" => "application/json",
            "Accept" => "application/json"
          }
        )
        logger.info "KAKAOMESSAGE #{response.to_yaml}"
      rescue StandardError
        logger.fatal "알림톡 에러"
      end
    end
  end

  private

  def create_secure_code; end
end
