class LinksController < ApplicationController
  
  before_action :find_by_code, only: [:redirectors, :preview]

  def index
  end	

  def new
  	@new_link = Link.new
  end

  def create
  	@new_link = Link.new(link_params)
    @new_link.code = SecureRandom.urlsafe_base64(8)
    if @new_link.save
			redirect_to link_path(@new_link.id)
		else
			render 'new'
		end
  end

  def show
    @new_link = Link.find params[:id]
  end

  def redirectors
    redirect_to(@new_link.url)
  end

  def preview
  end

  private

  def link_params
		params.require(:link).permit(:url)
	end

  def find_by_code
    @new_link = Link.find_by(:code=>params[:code])
  end

end