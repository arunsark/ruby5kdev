require 'spec_helper'
describe UsersHelper do
  describe "runkeeper_auth_endpoint" do
    it "fetches valid URL with params for endpoint" do
      params = "client_id=#{RunKeeper::CLIENT_ID}"
      params += "&" + "response_type=code"
      params += "&" + "redirect_uri=#{CGI.escape(RunKeeper::REDIRECT_URI)}"
      helper.runkeeper_auth_endpoint.should eq(RunKeeper::AUTHORIZATION_URL + "?" + params)
    end
  end
end
