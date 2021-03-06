class SurvivorsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_survivor, only:[:upvote, :downvote]

  def index
    @survivors = Survivor.all
    @currentUser = current_user.id
  end

  def show
    @survivors = Survivor.all
  end

  def search
    @survivors = Survivor.where("name LIKE ?", "%" + params[:q] + "%")
  end

  def upvote
    @survivor.upvote_from current_user
    if @survivor.get_upvotes.size >= 5
      @survivor.update(:infected => true)
    else
      @survivor.update(:infected => false)
    end
    redirect_to survivors_index_path
  end

  def downvote
    @survivor.downvote_from current_user
    redirect_to survivors_index_path
  end

  def infected_percentage
    survivors=Survivor.where(infected: true).count
    total = Survivor.count
    @survivors = survivors.to_f / total.to_f * 100
  end
  helper_method :infected_percentage
  helper_method :uninfected_percentage

  def uninfected_percentage
    survivors=Survivor.where(infected: false).count
    total = Survivor.count
    @survivors = survivors.to_f / total.to_f * 100
  end

  private
  def set_survivor
    @survivor = Survivor.find(params[:id])
  end
end
