class OrdersController < ApplicationController

  load_and_authorize_resource :account
  load_and_authorize_resource :laboratory, through: :account
  load_and_authorize_resource :order, through: :laboratory
  skip_load_resource :order, only: [:create, :index]

  before_filter :restore_order_query, only: :index

  def index
    @orders = @laboratory.orders

    if @order_params.trial_type_id
      @orders = @orders.where(trial_type_id: @order_params.trial_type_id)
    end

    if @order_params.doctor_id
      @orders = @orders.where(doctor_id: @order_params.doctor_id)
    end

    if @order_params.tracking_number && !@order_params.tracking_number.blank?
      @orders = @orders.where("tracking_number like '%#{@order_params.tracking_number}%'")
    end
    @orders = @orders.paginate(page: params[:page])

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
    data.row(0).concat [t('activerecord.models.order'),
                        t('activerecord.attributes.order.order_date'),
                        t('activerecord.models.doctor'),
                        t('activerecord.attributes.order.trial_type'),
                        t('activerecord.models.antibody')]
    header_format = Spreadsheet::Format.new :color => :green, :weight => :bold
    data.row(0).default_format = header_format

    trials = orders.collect do |order|
      order.trials.collect do |trial|
        {id: order.id,
         date: I18n.l(order.order_date),
         antibody_name: trial.antibody.name,
         doctor: order.doctor.name,
         trial_type: order.trial_type.name
        }
      end
    end
    trials = trials.flatten

    trials.each_with_index do |trial, i|
      data.row(i+1).push trial[:id], trial[:date], trial[:doctor], trial[:trial_type], trial[:antibody_name]
    end
    spreadsheet_file = StringIO.new('')
    book.write(spreadsheet_file)

    spreadsheet_file
  end

  def excel_file_name(company)
    "trials_#{Date.today.to_s.gsub('-', '_')}.xls"
  end

  def restore_order_query
    @order_params= params[:order] ? Order.new(order_params) : Order.new
  end

end
