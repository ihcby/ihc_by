class DoctorsController < ApplicationController

  load_and_authorize_resource :account
  load_and_authorize_resource :doctor, through: :account
  skip_load_resource :doctor, only: [:create, :index]

  def index
    @doctors = @account.doctors.paginate(page: params[:page])
    respond_with(@account, @doctor)
  end

  def show
    respond_with(@account, @doctor)
  end

  def new
    @doctor = @account.doctors.build
    respond_with(@account, @doctor)
  end

  def edit
  end

  def create
    @doctor = @account.doctors.new(doctor_params)
    @doctor.save
    respond_with(@account, @doctor)
  end

  def update
    @doctor.update(doctor_params)
    respond_with(@account, @doctor)
  end

  def destroy
    @doctor.destroy
    respond_with(@account, :doctors)
  end

  private
  def doctor_params
    params.require(:doctor).permit(:name)
  end
end
