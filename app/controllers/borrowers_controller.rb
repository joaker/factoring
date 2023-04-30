class BorrowersController < ApplicationController

    def show
        @borrower = Borrower.find(params[:id])
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

end
