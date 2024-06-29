class V1::ReservationsController < V1::BaseController
  def index
    date = Time.zone.parse(params[:date])
    start_date = date.beginning_of_month - 1.week
    end_date = date.end_of_month + 1.week
    reservations = Reservation.where('start_at >= ? AND end_at <= ?', start_date, end_date)
    render json: reservations
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
