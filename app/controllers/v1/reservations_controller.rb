class V1::ReservationsController < V1::BaseController
  def index
    date = Date.parse(params[:date])
    ## Reservations를 줄건데 현재 날짜 기준으로 해당 달이 포함된 예약들과 
    ## 앞뒤 전후 1주일간의 예약들을 보내준다.
  end

end
