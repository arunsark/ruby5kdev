require 'spec_helper'

describe Entry do

  it "is invalid without user" do
    entry = FactoryGirl.build(:entry)
    entry.user = nil
    entry.should_not be_valid
    entry.errors["user"].should include("can't be blank")
  end

  it "is invalid without distance and time" do
    entry = FactoryGirl.build(:entry)
    entry.time = nil
    entry.distance = nil
    entry.should_not be_valid
    entry.errors["distance"].should include("You must enter distance or time or both.")
  end

  it "is valid with only distance" do
    entry = FactoryGirl.build(:entry)
    entry.time = nil
    entry.should be_valid
  end

  it "is valid with only time" do
    entry = FactoryGirl.build(:entry)
    entry.distance = nil
    entry.should be_valid
  end

  describe "Entry from Runkeeper" do
    before do
      @activity = {
        "total_distance" => "1200.0",
        "duration" => "2400",
        "type" => "Running",
        "start_time" => "Wed, 8 May 2013 06:50:00",
        "uri" => "/f/12345"
      }
      @user = User.new
    end
    subject { Entry.create_entry_from_runkeeper(@activity, @user) }
    it "creates a new instance of entry" do
      subject.should be_instance_of(Entry)
    end
    it "converts duration to minutes from seconds" do
      subject.time.should eq(40)
    end
    it "converts distance to km from metres" do
      subject.distance.should eq(1.2)
    end
    it "converts start_time to correct format" do
      subject.start_time.day.should == 8
      subject.start_time.month.should == 5
      subject.start_time.year.should == 2013
    end
    it "assigns user" do
      subject.user.should eq(@user)
    end
    it "sets the entry mode" do
      subject.entry_mode.should eq("run_keeper")
    end
    it "sets the source_id" do
      subject.source_id.should eq(@activity["uri"])
    end
    context "persist the entry" do
      before do
        @user = FactoryGirl.create(:user)
      end
      it "saves the entry to db" do
        subject.should be_persisted
      end
    end
    context "entry already present" do
      before do
        FactoryGirl.create(:entry, entry_mode: "run_keeper", source_id: "/f/12345")
      end
      it "saves the entry to db" do
        subject.should_not be_persisted
      end
    end
  end
end
