class PartiesController < ApplicationController
  before_action :authenticate_user!

  def index
  	@parties=Party.where.not(user_id:current_user.id)
  end

  def show
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
		redirect_to parties_path
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

  private
  def party_params
  params.require(:party).permit(:place, :age, :people_count, :introduction)
  end

end
