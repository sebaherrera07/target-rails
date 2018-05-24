class ApplicationController < ActionController::Base
  # The path used after sign in.
  def after_sign_in_path_for(resource)
    targets_path(resource)
  end

  # The path used after sign out.
  def after_sign_out_path_for(resource)
    new_session_path(resource)
  end
end
