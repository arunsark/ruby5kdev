class Entry < ActiveRecord::Base
  validates :distance, :presence => { :unless => :time, :message => "You must enter distance or time or both." }
  validates :time, :presence => { :unless => :distance, :message => "You must enter distance or time or both." }
  attr_accessible :description, :distance, :location, :time
end
