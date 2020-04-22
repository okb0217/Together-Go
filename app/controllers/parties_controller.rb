class PartiesController < ApplicationController
  before_action :authenticate_user!

  def index
  	@parties=Party.where.not(user_id:current_user.id)
  end

  def show
    @party = Party.find(params[:id])
    @request = Request.find_by(partner_user_id:current_user.id, party_id:@party.id)
    # 各check変数を初期化
    @my_check = 1 #current_userがpartner_partyへリクエストしていない場合"１"
    @partner_check = 1 #partner_partyがcurrent_userをリクエストしていない場合"１"
    current_user.requests.each do |r|
      if r.partner_party_id == @party.id
        @my_check = 2#current_userがpartner_partyへリクエストしている場合"2"
        break
        end
      end
    @party.requests.each do |r|
      if r.partner_user_id == current_user.id
        @partner_check = 2#partner_partyがcurrent_userをリクエストしている場合"２"
        break
        end
      end
  end

  def new
  	if current_user.age.nil?
  		redirect_to user_path(current_user.id), notice: "先にプロフィール編集を行って下さい！"
  	else
  		@party=Party.new
  	end
  end

  def create
  	@party = Party.new(party_params)
  	@party.user_id=current_user.id
  	if  @party.save
		redirect_to user_path(current_user.id)
	else
		render :new
	end
  end

  def edit
  	@party = Party.find(params[:id])
  	unless current_user.id == @party.user.id
        redirect_to user_path(current_user.id)
    end
  end

  def update
  	@party = Party.find(params[:id])
  	if  @party.update(party_params)
		flash[:notice] = "You have updated party successfully."
	    redirect_to party_path(@party)
	else
	    render action: :edit
	end
  end

  def destroy
    party=Party.find(params[:id])
    party.destroy
    redirect_to user_path(current_user.id)
  end

  private
  def party_params
  params.require(:party).permit(:place, :age, :people_count, :introduction)
  end

end




