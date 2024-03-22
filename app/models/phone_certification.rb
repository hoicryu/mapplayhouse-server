class PhoneCertification < ApplicationRecord
  def check_code(received_code = nil)
    success = false
    msg = "인증번호가 올바르지 않습니다"
    if ((Time.current - updated_at) / 60).to_i >= 3
      msg = "인증시간이 초과되었습니다"
    elsif code == received_code
      update(confirmed_at: Time.zone.now)
      success = true
      msg = "인증에 성공하셨습니다"
    end
    { type: "check_code", success: success, message: msg }
  end

  # 인증코드 생성
  def self.generate_code(phone = nil)
    certification_code = find_or_create_by(phone: phone)
    generated_code = rand(999_999).to_s.rjust(6, "0")
    success = false
    if certification_code.update(code: generated_code) # 0 포함 6자리
      sms_message = SmsService.new(phone) # 코드 발송
      success = sms_message.send_sms("인증번호 : [#{generated_code}]")
    end
    { type: "generate_code", success: success }
  end
end
