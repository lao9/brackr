class Api::V1::BracksController < ActionController::API

  def index
    latlng = params[:latlng]
    @bracks = Brack.sort_by_distance(latlng)
    render json: @bracks, latlng: latlng
  end

  def create
    @brack = Brack.add_new(brack_params)
    if @brack.save
      render json: @brack
    else
      render json: @bracj.errors.full_messages, status: 500
    end
  end

  private

    def brack_params
      params.require(:brack).permit(:user_id, :lat, :long)
    end

end
