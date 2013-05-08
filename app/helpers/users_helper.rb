module UsersHelper
  def runkeeper_auth_endpoint
    params = "client_id=#{RunKeeper::CLIENT_ID}"
    params += "&" + "response_type=code"
    params += "&" + "redirect_uri=#{CGI.escape(RunKeeper::REDIRECT_URI)}"
    RunKeeper::AUTHORIZATION_URL + "?#{params}"
  end
end
