require 'spec_helper'

describe RunKeeper::FitnessFeed do
  subject { described_class.new }
  let(:user) { stub(:user, runkeeper_token: "THE_TOKEN") }

  context "fetch fitness activities of user" do
    before do
      response = "{\"items\":[{\"duration\":600,\"total_distance\":1455.16890742677,\"has_path\":true,\"entry_mode\":\"Web\",\"source\":\"RunKeeper\",\"start_time\":\"Thu, 9 May 2013 11:54:00\",\"type\":\"Running\",\"uri\":\"/fitnessActivities/178338392\"},{\"duration\":1200,\"total_distance\":3000,\"has_path\":false,\"entry_mode\":\"Web\",\"source\":\"RunKeeper\",\"start_time\":\"Wed, 8 May 2013 06:50:00\",\"type\":\"Running\",\"uri\":\"/fitnessActivities/177697803\"}],\"size\":2}"
      stub_request(:get, "https://api.runkeeper.com/fitnessActivities?noEarlierThan=2013-05-10").
         with(:headers => {'Accept'=>'application/vnd.com.runkeeper.FitnessActivityFeed+json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Authorization'=>'Bearer THE_TOKEN', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => response, :headers => {})
    end

    it "returns array of users past activity" do
      subject.activities(user, Date.new(2013, 5, 10)).count.should == 2
    end
  end

  context "error in fetch fitness activities of user" do
    before do
      stub_request(:get, "https://api.runkeeper.com/fitnessActivities?noEarlierThan=2013-05-10").
         with(:headers => {'Accept'=>'application/vnd.com.runkeeper.FitnessActivityFeed+json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Authorization'=>'Bearer THE_TOKEN', 'User-Agent'=>'Ruby'}).
        to_return(:status => 406, :body => "", :headers => {})
    end

    it "returns an empty array" do
      subject.activities(user, Date.new(2013, 5, 10)).should eq([])
    end
  end
end
