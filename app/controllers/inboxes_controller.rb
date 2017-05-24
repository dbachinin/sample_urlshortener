class InboxesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_inbox, only: [:show, :edit, :update, :destroy]

  # GET /inboxes
  # GET /inboxes.json
  def index
    @inboxes = Inbox.all
    @user = current_user
  end

  # GET /inboxes/1
  # GET /inboxes/1.json
  def show
    @user = current_user
      # @inbox = Inbox.find params[:id]
      @inbox = Inbox.find params[:id]
      @url = @inbox.shortmessage
      @inbox.read = true
      @inbox.save
  end

  # GET /inboxes/new
  def new
    @url = Link.find(params[:url]).display_slug
    @inbox = current_user.inboxes.build
  end

  # GET /inboxes/1/edit
  def edit
  end

  # POST /inboxes
  # POST /inboxes.json
  def create
    @inbox = current_user.inboxes.build(inbox_params)
    @inbox.sender = current_user.id

    respond_to do |format|
      if @inbox.save
        format.html { redirect_to @inbox, notice: 'You url has ben sent.' }
        format.json { render :show, status: :created, location: @inbox }
      else
        format.html { render :new }
        format.json { render json: @inbox.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inboxes/1
  # PATCH/PUT /inboxes/1.json
  def update
    respond_to do |format|
      if @inbox.update(inbox_params)
        format.html { redirect_to @inbox, notice: 'Inbox was successfully updated.' }
        format.json { render :show, status: :ok, location: @inbox }
      else
        format.html { render :edit }
        format.json { render json: @inbox.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inboxes/1
  # DELETE /inboxes/1.json
  def destroy
    @inbox.destroy
    respond_to do |format|
      format.html { redirect_to inboxes_url, notice: 'Inbox was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inbox
      @inbox = Inbox.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inbox_params
      params.require(:inbox).permit(:shortmessage, :sender, :reseiver, :read)
    end
end
