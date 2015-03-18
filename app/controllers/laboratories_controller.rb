class LaboratoriesController < ApplicationController

  load_and_authorize_resource :account
  load_and_authorize_resource :laboratory, through: :account
  skip_load_resource :laboratory, only: [:create, :index]

  def index
    @laboratories = @account.laboratories.paginate(page: params[:page])
    respond_with(@laboratories)
  end

  def show
    respond_with(@account,@laboratory)
  end

  def new
    @laboratory = @account.laboratories.new
    respond_with(@account,@laboratory)
  end

  def edit
  end

  def create
    @laboratory = @account.laboratories.new(laboratory_params)
    @laboratory.save
    respond_with(@account,@laboratory)
  end

  def update
    @laboratory.update(laboratory_params)
    respond_with(@account,@laboratory)
  end

  def destroy
    @laboratory.destroy
    respond_with(@account,:laboratories)
  end

  private

  def laboratory_params
    params.require(:laboratory).permit(:name)
  end
end
