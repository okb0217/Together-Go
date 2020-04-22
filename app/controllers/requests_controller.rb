class RequestsController < ApplicationController

  def index
    requests_for_me = Request.where(partner_user_id: current_user.id)
    my_requests = Request.where(user_id: current_user.id)
    filtered = []
    requests_for_me.each do |req|
      begin
        my_requests.find_by!(partner_user_id:req.user_id)
      rescue
        filtered.push req
      end
    end
    @requests = filtered
  end

  def show
    @request = Request.find(params[:id])
  end

  def new
    if current_user.parties.count == 0
      redirect_to user_path(current_user.id), notice: "先にパーティー登録を行って下さい！"
    else
  	@party = Party.find(params[:party_id])
  	@request = Request.new
    end
  end

  def create
  	@party = Party.find(params[:request][:partner_party_id])
  	@request = Request.new(request_params)
  	@request.save
  	redirect_to party_path(@party.id)
  end

  def destroy
    @party = Party.find(params[:party_id])
  	@request = Request.find_by(user_id:current_user.id, partner_party_id:@party.id)
  	@request.destroy
  	redirect_to party_path(@party.id)
  end

  private
  def request_params
  params.require(:request).permit(:user_id, :party_id, :partner_user_id, :partner_party_id)
  end
end