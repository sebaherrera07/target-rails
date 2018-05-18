class ApplicationController < ActionController::Base
  # The path used after sign in.
  def after_sign_in_path_for(*)
    '/targets'
  end

  # The path used after sign out.
  def after_sign_out_path_for(*)
    '/users/sign_in'
  end
end
