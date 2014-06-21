class LinksController < ApplicationController
  
  before_action :find_by_code, only: [:redirectors, :preview]

  def index
  end	

  def new
  	@new_link = Link.new
  end

  def create
  	@new_link = Link.new(link_params)
    @new_link.code = rand(10000)
    if @new_link.save
			redirect_to @new_link
      # redirect_to link_path(@new_link.id)
		else
			render 'new'
		end
  end

# Alternate create method for instance where a form is only in use once.

  # def create
  #   safe_link_params = params.require(:link).permit(:url)
  #   @new_link = Link.new(safe_url_params)
  #   @new_link.code = rand(1..10000)
  #   @new_link.save
  #   redirect_to @url #[Because we're in Rails, it knows we have a show template because of our resources in the root]
  # end


  def show
    @new_link = Link.find params[:id]
  end

  def redirectors
    if @new_link
      redirect_to(@new_link.url)
    else
      redirect_to root_path
    end
  end

  def preview
    unless @new_link
    end
  end

  private

  def link_params
		params.require(:link).permit(:url)
	end

  def find_by_code
    @new_link = Link.find_by code: params[:code]
  end

end