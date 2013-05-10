class RunkeeperActivityFeedWorker
  include Sidekiq::Worker
  def perform
    User.runkeepers.each do |user|
      fitness_activity_updater.update_entries_for(user)
    end
  end

  def fitness_activity_updater
    @fa ||= RunKeeper::FitnessActivityUpdater.new
  end
end
