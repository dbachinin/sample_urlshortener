class LinksController < ApplicationController
  before_filter :authenticate_user!
  #before_action :authenticate_user!, :except => [:show, :index]
  before_action :set_link, only: [:show]


  def index
    @user = current_user
    @link = Link.all

  end

  def show
    @user = current_user
    if params[:slug]
      @link = Link.find_by(slug: params[:slug])
      if redirect_to @link.given_url
       # @link.clicks += 1
        @link.save
      end
    else
      @link = Link.find(params[:id])
    end
  end


  def new
      @link = current_user.links.build
      @user = current_user
  end

  def create
    @link = current_user.links.build(link_params)
#    @link.title = @link.given_url if @link.given_url.length == 4

    respond_to do |format|
      if @link.save
        format.html { redirect_to @link, notice: 'Link was successfully created.' }
        format.json { render :show, status: :created, location: @link }
      else
        format.html { render :new }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end


   def destroy
    @link = Link.find(params[:id])
    if @link.present?
     @link.destroy
     respond_to do |format|
       format.html { redirect_to links_url, notice: 'Link was successfully destroyed.' }
       format.json { head :no_content }
     end
     else
      redirect_to root_path
     end
   end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
#      @link = Link.find(params[:id])
        @link = Link.find_by(slug: params[:slug])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:given_url, :slug)
    end
end
