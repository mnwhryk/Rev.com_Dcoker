class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # ログイン時に遷移するpathを設定
  def after_sign_in_path_for(_resource)
    root_path
  end

  # ログアウト後に遷移するpathを設定
  def after_sign_out_path_for(_resource)
    root_path
  end

  def configure_permitted_parameters
    if resource_class == User
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email])
      devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
      devise_parameter_sanitizer.permit(:account_update, keys: %i[name email])
    end
  end
end
