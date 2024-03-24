module V1
  class UsersController < V1::BaseController
    def index
      render json: each_serialize(User.all.sample(4), serializer_name: :UserSerializer, context: { current_api_user: current_api_user })
    end

    def show
      user = User.find(params[:id])
      render json: serialize(user, context: { current_api_user: current_api_user })
    end

    def image
      current_api_user.update(image: params[:image])
      render json: current_api_user.image_path
    end

    def update
      result = current_api_user.update(user_params)
      render json: { result: result }
    end

    def create
      user = User.new(signup_params)
      user.uid = sub
      user.save!
    end

    def me
      render json: serialize(current_api_user, serializer_name: :CurrentUserSerializer)
    end

    def kakao 
      begin
        @response = HTTParty.get(
          'https://kapi.kakao.com/v2/user/me',
          headers: {
            "Authorization": "Bearer #{params[:access_token]}",
            "Content-type": 'application/x-www-form-urlencoded',
            "charset": 'utf-8'
          }
        )
        if @response.code == 200
          email = @response.dig('kakao_account', 'email')
          nickname = @response.dig('properties', 'nickname')
          email ||= "#{DateTime.now.strftime('%Q')}@kakao.login"
          result = User.login('kakao', @response.dig('id').to_s, email, nickname)
        end
      rescue
        result = false
      end 
      render json: result
    end

    def naver
      begin
        @response = HTTParty.get(
          'https://openapi.naver.com/v1/nid/me',
          headers: {
            "Authorization": "Bearer #{params[:access_token]}",
            "Content-type": 'application/x-www-form-urlencoded',
            "charset": 'utf-8'
          }
        ).parsed_response

        if @response['resultcode'] == "00"
          email = @response.dig('response', 'email')
          nickname = @response.dig('response', 'nickname')
          id = @response.dig('response', 'id')
          email ||= "#{DateTime.now.strftime('%Q')}@naver.login"
          result = User.login('naver', id, email, nickname)
        end
      rescue
        result = false
      end 
      render json: result
    end

    private

    def user_params
      params.require(:user).permit(:name, :email, :image, :nickname)
    end

    def index_params
      params.fetch(:q, {}).permit(User::INDEX_PERMIT)
    end

    def medal_params
      params.fetch(:q, {}).permit(:event_sport_name_eq)
    end

    def signup_params
      params.require(:user).permit(User::USER_COLUMNS)
    end
  end
end
