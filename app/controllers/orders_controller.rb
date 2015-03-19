class OrdersController < ApplicationController

  load_and_authorize_resource :account
  load_and_authorize_resource :laboratory, through: :account
  load_and_authorize_resource :order, through: :laboratory
  skip_load_resource :order, only: [:create, :index]

  def index
    @orders = @laboratory.orders.paginate(page: params[:page])
    respond_with(@account, @laboratory, @orders)
  end

  def export
    orders = @laboratory.orders.includes(trials: [:antibody]).joins(trials: [:antibody])
    send_data prepare_excel(orders).string.bytes.to_a.pack('C*'), type: 'application/excel', disposition: 'attachment', filename: excel_file_name(@laboratory)
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
    @order.update(order_params)
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


  def prepare_excel(orders)
    book = Spreadsheet::Workbook.new
    data = book.create_worksheet :name => 'Исследования'
    data.row(0).concat ['Заказ', 'Дата', 'Антитело']
    header_format = Spreadsheet::Format.new :color => :green, :weight => :bold
    data.row(0).default_format = header_format

    trials = orders.collect { |order| order.trials.collect { |trial| {id: order.id ,date: I18n.l(order.order_date), antibody_name: trial.antibody.name } }}.flatten

    trials.each_with_index do |trial, i|
      data.row(i+1).push trial[:id], trial[:date], trial[:antibody_name]
    end
    spreadsheet_file = StringIO.new('')
    book.write(spreadsheet_file)

    spreadsheet_file
  end

  def excel_file_name(company)
    "trials_#{Date.today.to_s.gsub('-', '_')}.xls"
  end

end
