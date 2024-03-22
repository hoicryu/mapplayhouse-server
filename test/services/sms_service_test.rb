require "test_helper"

class SmServiceTest < ActiveSupport::TestCase
  setup do
    @sms = SmService.create!
  end

  test "sms 생성" do
    sms_id = @sms.id
    service = SmService.new(sms_id)
    pp service.build_sms(sms_id).attributes
  end
end
