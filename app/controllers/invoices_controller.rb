class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :update]
  
  def index
    invoices = Invoice.all
    render json: invoices
  end
  
  def show
    render json: @invoice
  end
  
  def create
    invoice = Invoice.new(invoice_params)
    if invoice.save
      render json: invoice, status: :created
    else
      render json: invoice.errors, status: :unprocessable_entity
    end
  end
  
  def update

    if params[:status] == 'closed'
      percentage = @invoice.fee.percentage
      daily_accrued = @invoice.amount * percentage;

      two_days_after_due_date = @invoice.due_date + 2.days;
      days_accrued = (two_days_after_due_date - DateTime.now).to_i

      @invoice.total_accrued = daily_accrued * days_accrued      
    end

    if @invoice.update(status: params[:status])
      render json: @invoice
    else
      render json: @invoice.errors, status: :unprocessable_entity
    end
  end
  
  private
  
  def set_invoice
    @invoice = Invoice.find(params[:id])
  end
  
  def invoice_params
    params.require(:invoice).permit!
  end
end
