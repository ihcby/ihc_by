class PicturesController < ApplicationController

  load_and_authorize_resource :account
  load_and_authorize_resource :laboratory, through: :account
  load_and_authorize_resource :order, through: :laboratory
  load_and_authorize_resource :trial, through: :order
  load_and_authorize_resource :picture, through: :trial
  skip_load_resource :picture, only: [:create, :index]


  def new
  end

  def create
    @trial.pictures.create(picture_params)
    respond_with(@account, @laboratory, @order, @trial)
  end

  def destroy
    @picture.destroy
    respond_with(@account, @laboratory, @order, @trial)
  end

  private

  def picture_params
    params.require(:picture).permit(:image)
  end

end
