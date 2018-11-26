class PollResponsesController < ApplicationController
  before_action :set_poll

  def create
    @poll_response = @poll.poll_responses.new(poll_response_params)
    @poll_response.user = current_user
    if @poll_response.save
      redirect_to poll_poll_responses_path(@poll), notice: "Your vote has been recorded"
    else
      redirect_back fallback_location: @poll, alert: "Something went wrong: #{@poll_response.errors.full_messages.join(', ')}"
    end
  end

  def index
    respond_to do |format|
      format.html do
        @restaurants = @poll.restaurants
        @order = Order.new
      end

      @results  = PollResponse.where(poll: @poll).group_by do |response|
                    response.restaurant.name
                  end.transform_values{ |v| v.count }

      format.json do
        render json: @results
      end
    end
  end

  private

  def set_poll
    @poll = Poll.find(params[:poll_id])
  end

  def poll_response_params
    params.require(:poll_response).permit(:restaurant_id)
  end

end
