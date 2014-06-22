class LinksController < ApplicationController
    
  before_action :find_by_code, only: [:redirectors, :preview]
  before_action :authenticate_user!
  before_action :set_link, only: [:edit, :destroy]

  def index
    @user_links = current_user.links.all
  end	

  def new
  	@link = current_user.links.build #Link.new
  end

  def edit
  end

  def create
  	@link = current_user.links.build(link_params)
    @link.code = rand(10000)
    if @link.save
			redirect_to @link
      # redirect_to link_path(@link.id)
		else
			render 'new'
		end
  end

# Alternate create method for instance where a form is only in use once.

  # def create
  #   safe_link_params = params.require(:link).permit(:url)
  #   @link = Link.new(safe_url_params)
  #   @link.code = rand(1..10000)
  #   @link.save
  #   redirect_to @url #[Because we're in Rails, it knows we have a show template because of our resources in the root]
  # end


  def show
    @link = Link.find params[:id]
  end

  def destroy
    @link.destroy
    redirect_to links_url
  end

  def redirectors
    if @link
      redirect_to(@link.url)
    else
      redirect_to root_path
    end
  end

  def preview
    unless @link
    end
  end

  private

  def link_params
		params.require(:link).permit(:url)
	end

  def set_link
    @link = current_user.links.find_by(id: params[:id])
    redirect_to root_path, notice: "Not authorized to access section of Ritly." if @link.nil?
  end

  def find_by_code
    @link = Link.find_by code: params[:code]
  end

end