class SurvivorsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_survivor, only:[:upvote, :downvote]

  def index
    @survivors = Survivor.all
  end

  def search
    @survivors = Survivor.where("name LIKE ?", "%" + params[:q] + "%")
  end

  def upvote
    @survivor.upvote_from current_user
    redirect_to survivors_index_path
  end

  def downvote
    @survivor.downvote_from current_user
    redirect_to survivors_index_path
  end

  private
  def set_survivor
    @survivor = Survivor.find(params[:id])
  end
end
