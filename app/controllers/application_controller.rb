class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  respond_to :html


  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end


  def set_account
    @account = Account.find(params[:account_id])
  end
end
