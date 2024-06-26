class V1::ReservationsController < V1::BaseController
  def index
    date = Date.parse(params[:date])
    ## Reservations를 줄건데 현재 날짜 기준으로 해당 달이 포함된 예약들과 
    ## 앞뒤 전후 1주일간의 예약들을 보내준다.
  end

  def create
    new_start_at = Time.zone.parse(reservation_params[:start_at])
    new_end_at = Time.zone.parse(reservation_params[:end_at])
    is_any_overlaps_in_start_at = Reservation.not_rejected.where("start_at <= ?", new_start_at).where("end_at >= ?", new_start_at).present?
    is_any_overlaps_in_end_at = Reservation.not_rejected.where("start_at <= ?", new_end_at).where("end_at >= ?", new_end_at).present?
    is_impossible = is_any_overlaps_in_start_at ||  is_any_overlaps_in_end_at
    if !is_impossible 
      result = current_api_user.reservations.create(reservation_params)
    else
      result = false
    end
    render json: result
  end

  def for_day
    date = Time.zone.parse(params[:date])
    reservations = Reservation.not_rejected.where("start_at >= ?", date).where("end_at <= ?", date.next_day())
    render json: reservations
  end

  private

  def reservation_params
      params.require(:reservation).permit(:start_at, :end_at, :num_of_people, :note)
  end
end
