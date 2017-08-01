class Api::V1::BracksController < ApplicationController

  def index
    latlng = params[:latlng]
    @bracks = Brack.sort_by_distance(latlng)
    render json: @bracks, latlng: latlng
  end

  def show
    @brack = Brack.find(params[:id])
    render json: @brack, latlng: params[:latlng]
  end

end
