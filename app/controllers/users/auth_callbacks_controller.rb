class Users::AuthCallbacksController < ApplicationController
  def run_keeper_auth
    if params[:code].present?
      token_fetcher = RunKeeperTokenFetcher.new(self, params[:code])
      access_token = token_fetcher.fetch_access_token
    else
      render nothing: true
    end
  end

  def fetched_runkeeper_token(access_token)
    flash[:notice] = "Your account has been linked to your Runkeeper account. We will be downloading your fitness activities from Runkeeper periodically."
    current_user.update_attributes(runkeeper_token: access_token)
    redirect_to current_user
  end

  def runkeeper_token_error
    flash[:error] = "Some problems prevented from linking your account with your Runkeeper account."
    redirect_to current_user
  end
end
