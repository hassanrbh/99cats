class CatRentalRequestsController < ApplicationController
    def new
        if current_user.nil?
            redirect_to new_session_path
            return
        end
        render :new
    end

    def approve
        current_cat_rental_request.approve!
        redirect_to cat_url(current_cat)
    end

    def deny
        current_cat_rental_request.deny!
        redirect_to cat_url(current_cat)
    end
    def create
        @cat_rental_request = CatRentalRequest.new(catrentalrequests_params)
        if @cat_rental_request.save
            redirect_to cat_url(@cat_rental_request.cat_id)
        else
            render :json => @cat_rental_request.errors.full_messages, :status => :unprocessable_entity
        end
    end
    
    private

    def catrentalrequests_params
        params.require(:cat_rental_requests).permit(:cat_id, :start_date, :end_date, :status)
    end

    def current_cat_rental_request
        @rental_request ||= CatRentalRequest.find(params[:id])
    end

    def current_cat
        current_cat_rental_request.cat
    end
end