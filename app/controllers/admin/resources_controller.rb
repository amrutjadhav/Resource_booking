class Admin::ResourcesController < ApplicationController
	before_action :find_company
	before_action :find_resource, only: [:edit, :update, :destroy]

	load_and_authorize_resource :resource
	def index
		@resources = @company.resources
	end

	def new
		@resource = @company.resources.build
	end
	
	def create
		@resource = @company.resources.build(resource_params)
		if @resource.save
			flash[:success] = "Resource is successfully created."
			redirect_to admin_resources_path
		else
			render :new
		end
	end
	

	def show
		resource = resource_array.collect {|x|  x[1] }
		if !resource.include?(params[:id].to_i)
			flash[:danger] = "no such resource"
			redirect_to root_path
		else
			redirect_to :admin_resources
		end
	end
	
	def edit; 	end

	def update
		if @resource.update(resource_params)
			flash[:success] = "Resource is successfully updated."
			redirect_to admin_resources_path
		else
			render :edit
		end
	end
	
	def destroy
		if @resource.destroy
			flash[:success] = "Resource and its complaints, bookings are destroyed."
		else
			flash[:error] = "Error while deleting resource"
		end
		redirect_to admin_resources_path
	end

	private
	
	def resource_params
		params.require(:resource).permit(:name, :company_id,:time_slot)
	end
	
	def find_resource
		@resource = @company.resources.find(params[:id])
	end

end

