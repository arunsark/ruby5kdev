class RunKeeper::FitnessActivityUpdater
  attr_accessor :feed
  def update_entries_for(user)
    feed.activities(user).each do |activity|
      Entry.create_entry_from_runkeeper(activity, user)
    end
  end

  private
  def feed
    @feed ||= RunKeeper::FitnessFeed.new
  end
end
