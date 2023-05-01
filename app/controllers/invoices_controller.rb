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
