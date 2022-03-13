class CatRentalRequestsController < ApplicationController
    def new
        if current_user.nil?
            redirect_to new_session_path
            return
        end
        render :new
    end

    def create
        @cat_rental_request = CatRentalRequest.new(catrentalrequests_params)
        if @cat_rental_request.save
            redirect_to cat_url(@cat_rental_request.cat_id)
        else
            render :json => @cat_rental_request.errors.full_messages, :status => :unprocessable_entity
        end
    end
    
    protected
    def catrentalrequests_params
        params.require(:cat_rental_requests).permit(:cat_id, :start_date, :end_date, :status)
    end
end