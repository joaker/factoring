class BorrowersController < ApplicationController
    before_action :set_post, only: [:show]

    def show
        render json: @borrower
    end

    def create
        @fee = Borrower.new(fee_params)
    
        if @fee.save
          render json: @fee, status: :created
        else
          render json: @fee.errors, status: :unprocessable_entity
        end
    end

    private
        def fee_params
            params.require(:borrower).permit(:name)
        end

        def set_post
            @borrower = Borrower.find(params[:id])
        end

end
