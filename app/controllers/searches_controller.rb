class SearchesController < ApplicationController

  def search
    users = User.where(is_gender: false)
    man_users = []
    users.each do |user|
      man_users.push user.id
    end
    @parties = Party.where.not(user_id: current_user.id)
    @parties = @parties.where("place like ?", "%#{params[:place]}%") if params[:place].present?
    @parties = @parties.where("age like ?", "%#{params[:age]}%") if params[:age].present?
    @parties = @parties.where("people_count like ?", "%#{params[:people_count]}%") if params[:people_count].present?
    @parties = @parties.where(user_id: man_users) if params[:gender] == "1"
    @parties = @parties.where.not(user_id: man_users) if params[:gender] == "2"
    render action: :search
  end
end
