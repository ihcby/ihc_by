class TrialsController < ApplicationController

  load_and_authorize_resource :account
  load_and_authorize_resource :laboratory, through: :account
  load_and_authorize_resource :order, through: :laboratory
  load_and_authorize_resource :trial, through: :order
  skip_load_resource :trial, only: [:create, :index]
  before_filter :load_antibodies, only: [:new, :edit]

  def new
  end



  def edit
  end

  def create
    # todo validate duplicated antibodies
    trials_params.each do |antibody_id|
      @order.trials.create(antibody_id: antibody_id.to_i)
    end

    respond_with(@account, @laboratory, @order)
  end

  def show
  end

  def update
    @trial.update(trial_params)
    respond_with(@account, @laboratory, @order)
  end

  def destroy
    @trial.destroy
    respond_with(@account, @laboratory, @order)
  end

  private

  def trial_params
    params.require(:trial).permit(:antibody_id)
  end
  def trials_params
    params.require(:antibodies_ids)
  end

  def load_antibodies
    @antibodies = Antibody.all
  end

end
