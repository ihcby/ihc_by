class TrialTypesController < ApplicationController

  load_and_authorize_resource :account
  load_and_authorize_resource :laboratory, through: :account
  load_and_authorize_resource :trial_type, through: :laboratory
  skip_load_resource :trial_type, only: [:create, :index]

  def index
    @trial_types = @laboratory.trial_types.paginate(page: params[:page])
    respond_with(@trial_types)
  end

  def show
    respond_with(@account, @laboratory, @trial_type)
  end

  def new
    @trial_type = @laboratory.trial_types.build
    respond_with(@account, @laboratory, @trial_type)
  end

  def edit
  end

  def create
    @trial_type = @laboratory.trial_types.new(trial_type_params)
    @trial_type.save
    respond_with(@account, @laboratory, @trial_type)
  end

  def update
    @trial_type.update(trial_type_params)
    respond_with(@account, @laboratory, @trial_type)
  end

  def destroy
    @trial_type.destroy
    respond_with(@account, @laboratory, :trial_types)
  end

  private

  def trial_type_params
    params.require(:trial_type).permit(:name)
  end

end
