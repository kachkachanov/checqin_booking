class Users::SessionsController < Devise::SessionsController
  layout 'auth'

  def new
    super
  end

  def create
    super
  end

  def destroy
    super
  end

  protected

  def after_sign_in_path_for(resource)
    return admin_root_path if resource.admin?
    return supervisor_root_path if resource.supervisor?

    root_path
  end
end
