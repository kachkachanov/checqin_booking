class Users::RegistrationsController < Devise::RegistrationsController
  layout 'auth'

  before_action :normalize_role_param, only: :create

  def new
    super
  end

  def create
    super
  end

  def update
    super
  end

  protected

  def after_sign_up_path_for(resource)
    resource.supervisor? ? supervisor_root_path : root_path
  end

  def after_inactive_sign_up_path_for(resource)
    after_sign_up_path_for(resource)
  end

  private

  def normalize_role_param
    params[:user] ||= {}
    params[:user][:role] = supervisor_signup? ? 'supervisor' : 'user'
  end

  def supervisor_signup?
    params[:account_type] == 'supervisor' || params.dig(:user, :role) == 'supervisor'
  end
end
