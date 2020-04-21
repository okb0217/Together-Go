class RequestsController < ApplicationController

  def index
    @requests1 = Request.where(partner_user_id:current_user.id)
    @requests2 = @requests1.where.not()
  end

  def show
  end

  def new
  	@party = Party.find(params[:party_id])
  	@request = Request.new
  end

  def create
  	@party = Party.find(params[:request][:partner_party_id])
  	@request = Request.new(request_params)
  	@request.save
  	redirect_to party_path(@party.id)
  end

  def destroy
    @party = Party.find(params[:party_id])
  	request = Request.find_by(user_id:current_user.id, partner_party_id:@party.id)
  	request.destroy
  	redirect_to party_path(@party.id)
  end

  private
  def request_params
  params.require(:request).permit(:user_id, :party_id, :partner_user_id, :partner_party_id)
  end
end