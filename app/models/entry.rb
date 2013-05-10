class Entry < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  validates :distance, :presence => { :unless => :time, :message => "You must enter distance or time or both." }
  validates :time, :presence => { :unless => :distance, :message => "You must enter distance or time or both." }
  validates :user, :presence => true

  def self.create_entry_from_runkeeper(activity, user)
    entry = Entry.new
    entry.distance = activity["total_distance"].to_f / 1000.0
    entry.time = activity["duration"].to_i / 60
    entry.entry_mode = "run_keeper"
    entry.user = user
    entry.description = activity["type"]
    entry.start_time = activity["start_time"]
    entry.source_id = activity["uri"]
    unless Entry.where(entry_mode: entry.entry_mode, source_id: entry.source_id).any?
      entry.save
    end
    entry
  end

  def runkeeper_entry_present?(entry)
    Entry.where(entry_mode: "run_keeper", source_id: entry.source_id).any?
  end

  def self.update_entry(entry, user)
    Entry.where()
  end

  attr_accessible :description, :distance, :location, :time, :user
end
