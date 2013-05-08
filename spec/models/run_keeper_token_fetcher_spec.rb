require 'spec_helper'

describe RunKeeperTokenFetcher do

  let(:listener) { stub(:listener).as_null_object }
  let(:code) { "THE_CODE" }

  before do
    @it = described_class.new(listener, code)
  end

  context "fetch access token" do
    before do
      stub_request(:post, RunKeeper::ACCESS_TOKEN_URL).
        with(body: {client_id: RunKeeper::CLIENT_ID, client_secret: RunKeeper::CLIENT_SECRET, code: code, grant_type: "authorization_code", redirect_uri: RunKeeper::REDIRECT_URI},
        :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/x-www-form-urlencoded', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => "{\"access_token\":\"THE_TOKEN\"}", :headers => {})
    end
    it "passes the token to listener" do
      listener.should_receive(:fetched_runkeeper_token).with("THE_TOKEN")
      @it.fetch_access_token
    end
  end

  context "could not fetch access token" do
    before do
      stub_request(:post, RunKeeper::ACCESS_TOKEN_URL).
        with(body: {client_id: RunKeeper::CLIENT_ID, client_secret: RunKeeper::CLIENT_SECRET, code: code, grant_type: "authorization_code", redirect_uri: RunKeeper::REDIRECT_URI},
        :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/x-www-form-urlencoded', 'User-Agent'=>'Ruby'}).
        to_return(:status => 404, :body => "{}", :headers => {})
    end
    it "passes token not fetched message to listener" do
      listener.should_receive(:runkeeper_token_error).with(no_args)
      @it.fetch_access_token
    end
  end
end
