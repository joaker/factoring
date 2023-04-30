class FeesController < ApplicationController
  before_action :set_post, only: [:show]

  def show
      render json: @fee
  end

  def create
      @fee = Fee.new(fee_params)
  
      if @fee.save
        render json: @fee, status: :created
      else
        render json: @fee.errors, status: :unprocessable_entity
      end
  end

  private
      def fee_params
          params.require(:fee).permit(:percentage)
      end

      def set_post
          @fee = Fee.find(params[:id])
      end
end
