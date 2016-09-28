class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_employee!
  include Admin::ResourcesHelper
  before_action :configure_permitted_parameters, if: :devise_controller?
  load_and_authorize_resource

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end
  def give_id(company_id)
    resources = Resource.where(company_id:company_id)
    @id_array = []
    resources.each do |res|
      @id_array << res.id 
    end
    @id_array
  end
  def admin?
    find_company
    print "-----------------hello-----------------------"
    if current_employee.email != "admin@#{@company.name}.com"
      redirect_to root_path
    end
  end
end
