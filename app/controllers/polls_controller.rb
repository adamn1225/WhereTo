class PollsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_poll, only: [:show, :edit, :update, :destroy]
  before_action :validate_admin, only: [:new, :create, :destroy, :update, :edit]

  # GET /polls
  # GET /polls.json
  def index
    @polls = Poll.all
  end

  # GET /polls/1
  # GET /polls/1.json
  def show
    @poll = Poll.last
    if PollResponse.where(user: current_user, poll: @poll).exists?
      return redirect_to poll_poll_responses_path(@poll), notice: "Your vote has already been recorded!"
    end
    if DateTime.now > @poll.end_time
      redirect_to poll_poll_responses_path(@poll)
    end
    unless @poll.closed? 
      redirect_to poll_poll_responses_path(@poll)
    end
    @poll_response = @poll.poll_responses.new
  end

  # GET /polls/new
  def new
    @poll = Poll.new
  end

  # GET /polls/1/edit
  def edit
  end

  # POST /polls
  # POST /polls.json
  def create
    @poll = current_user.polls.create(date: Date.today)
    poll_params[:restaurant_id].each do |restaurant_id|
      @poll.restaurant_polls.find_or_create_by(restaurant_id: restaurant_id)
    end
    render json: @poll
  end

  # PATCH/PUT /polls/1
  # PATCH/PUT /polls/1.json
  def update
    respond_to do |format|
      if @poll.update(poll_params)
        format.html { redirect_to @poll, notice: 'Poll was successfully updated.' }
        format.json { render :show, status: :ok, location: @poll }
      else
        format.html { render :edit }
        format.json { render json: @poll.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /polls/1
  # DELETE /polls/1.json
  def destroy
    @poll.destroy
    respond_to do |format|
      format.html { redirect_to polls_url, notice: 'Poll was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_poll
      @poll = Poll.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def poll_params
      params.require(:poll).permit(:restaurant_id => [])
    end

    def validate_admin
      redirect_to users_path unless current_user.admin?
    end
end
