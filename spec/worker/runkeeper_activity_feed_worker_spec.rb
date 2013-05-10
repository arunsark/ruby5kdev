require 'spec_helper'
require 'sidekiq/testing'

describe RunkeeperActivityFeedWorker do
  before do
    FactoryGirl.create(:user)
    FactoryGirl.create(:runkeeper_user)
    @worker = described_class.new
    date = (Date.today - 1).strftime("%Y-%m-%d")
    response = "{\"items\":[{\"duration\":600,\"total_distance\":1455.16890742677,\"start_time\":\"Thu, 9 May 2013 11:54:00\",\"type\":\"Running\",\"uri\":\"/fitnessActivities/178338392\"}]}"
    stub_request(:get, "https://api.runkeeper.com/fitnessActivities?noEarlierThan=#{date}").
      with(:headers => {'Accept'=>'application/vnd.com.runkeeper.FitnessActivityFeed+json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Authorization'=>'Bearer THE_TOKEN', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => response, :headers => {})
  end

  it "updates users training entried" do
    lambda do
      @worker.perform
    end.should change(Entry,:count).by(1)
  end

  it "updates job queue" do
    expect {
      described_class.perform_async
    }.to change(described_class.jobs, :size).by(1)
  end
end
