class OrdersController < ApplicationController

  load_and_authorize_resource :account
  load_and_authorize_resource :laboratory, through: :account
  load_and_authorize_resource :order, through: :laboratory
  skip_load_resource :order, only: [:create, :index]

  def index
    @orders = @laboratory.orders.paginate(page: params[:page])
    respond_with(@account, @laboratory, @orders)
  end

  def show
  end

  def new
    @order = @laboratory.orders.build
    respond_with(@account, @laboratory, @order)
  end

  def edit
  end

  def create
    @order = @laboratory.orders.build(order_params)
    @order.save
    respond_with(@account, @laboratory, @order)
  end

  def update
    @laboratory.update(laboratory_params)
    respond_with(@account, @laboratory, @order)
  end

  def destroy
    @order.destroy
    respond_with(@account, @laboratory, :orders)
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def order_params
    params.require(:order).permit(:order_date, :doctor_id, :trial_type_id, :conclusion, :tracking_number, :trials_id, :comment)
  end
end
