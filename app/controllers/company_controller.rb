	class CompanyController < ApplicationController
		skip_before_action :authenticate_employee!, only: [:new, :create]
	def index

	end
	def new
		@company = Company.new
	end

	def create
		@company = Company.new(company_params)
		if @company.save
			redirect_to @company
		else
			render :new
		end
	end

	def show
		@company = Company.find(params[:id])
	end

	private

	def company_params
		params.require(:company).permit(:name,:email,:phone,:start_time,:end_time)
	end

end
