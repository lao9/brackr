class BracksController < ApplicationController
  before_action :authenticate_user, only: [:new, :edit]
  before_action :set_brack, only: [:edit, :update]

  def index
  end

  def new
  end

  def edit
    unless request.referer && (URI(request.referer).path == "/bracks/new")
      render file: "/public/404"
    end
  end

  def update
    if @brack.update_attributes(brack_params)
      flash[:notice] = "New Bike Rack Added!"
      redirect_to bracks_path
    else
      flash[:error] = "There was an issue saving your new bike rack."
      redirect_to bracks_path
    end
  end

  private

    def set_brack
      @brack = Brack.find(params[:id])
    end

    def brack_params
      params.require(:brack).permit(:cross_streets, :owner)
    end

end
